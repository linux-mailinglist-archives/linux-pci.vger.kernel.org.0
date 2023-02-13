Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F58695407
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 23:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjBMWoe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 13 Feb 2023 17:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBMWod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 17:44:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD0620D07
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 14:44:21 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-bQdp4kpzOVOJNtCS0YM40g-1; Mon, 13 Feb 2023 22:44:17 +0000
X-MC-Unique: bQdp4kpzOVOJNtCS0YM40g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Mon, 13 Feb
 2023 22:44:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Mon, 13 Feb 2023 22:44:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bjorn Helgaas' <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Stefan Roese <sr@denx.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH RFC] PCI/AER: Enable internal AER errors by default
Thread-Topic: [PATCH RFC] PCI/AER: Enable internal AER errors by default
Thread-Index: AQHZP/OWtZukbVOH0kqW0g36cswuDK7NdzVQ
Date:   Mon, 13 Feb 2023 22:44:16 +0000
Message-ID: <f5d13d0d67a34567a586a1171ba44b52@AcuMS.aculab.com>
References: <20230209-cxl-pci-aer-v1-1-f9a817fa4016@intel.com>
 <20230213213820.GA2935044@bhelgaas>
In-Reply-To: <20230213213820.GA2935044@bhelgaas>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas
> Sent: 13 February 2023 21:38
> 
> On Fri, Feb 10, 2023 at 02:33:23PM -0800, Ira Weiny wrote:
> > The CXL driver expects internal error reporting to be enabled via
> > pci_enable_pcie_error_reporting().  It is likely other drivers expect the same.
> > Dave submitted a patch to enable the CXL side[1] but the PCI AER registers
> > still mask errors.
> >
> > PCIe v6.0 Uncorrectable Mask Register (7.8.4.3) and Correctable Mask
> > Register (7.8.4.6) default to masking internal errors.  The
> > Uncorrectable Error Severity Register (7.8.4.4) defaults internal errors
> > as fatal.
> >
> > Enable internal errors to be reported via the standard
> > pci_enable_pcie_error_reporting() call.  Ensure uncorrectable errors are set
> > non-fatal to limit any impact to other drivers.
> 
> Do you have any background on why the spec makes these errors masked
> by default?  I'm sympathetic to wanting to learn about all the errors
> we can, but I'm a little wary if the spec authors thought it was
> important to mask these by default.

I'd guess that it is for backwards compatibility with older hardware
and/or software that that didn't support error notifications.

Then there are the x86 systems that manage to take the AER
error into some 'board management hardware' which finally
interrupts the kernel with an NMI - and the obvious consequence.
These systems are NEBS? 'qualified' for telecoms use, but take
out a PCIe link and the system crashes.

It is pretty easy to generate a PCIe error.
Any endpoint with two (or more) different sized BARs leaves
a big chunk of PCIe address space that is forwarded by the upstream
bridge but is not responded to.
The requirement to put the MSI-X area in its own BAR pretty much
ensures that such addresses exist.

(Never mind reprogramming the fpga that is terminating the link.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

