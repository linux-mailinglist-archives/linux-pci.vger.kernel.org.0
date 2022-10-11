Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D468B5FB1CD
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 13:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJKLsM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 11 Oct 2022 07:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJKLsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 07:48:11 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0FDE41
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2022 04:48:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-158-Lh8fam-hP0CDpIxos_Mzhw-1; Tue, 11 Oct 2022 12:48:07 +0100
X-MC-Unique: Lh8fam-hP0CDpIxos_Mzhw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 11 Oct
 2022 12:48:05 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 11 Oct 2022 12:48:05 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Leon Romanovsky' <leon@kernel.org>, Rui Ma <Rui.Ma@amd.com>
CC:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory
 occupied by PTEs
Thread-Topic: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory
 occupied by PTEs
Thread-Index: AQHY3WXQJdhdERmAOESu97r3UBgaK64JE0ig
Date:   Tue, 11 Oct 2022 11:48:05 +0000
Message-ID: <da760d45e4714a289220591a0f2efb97@AcuMS.aculab.com>
References: <20221011112325.992317-1-Rui.Ma@amd.com> <Y0VVXB0XTobClVJo@unreal>
In-Reply-To: <Y0VVXB0XTobClVJo@unreal>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Leon Romanovsky
> Sent: 11 October 2022 12:37
> 
> On Tue, Oct 11, 2022 at 07:23:25PM +0800, Rui Ma wrote:
> > In some certain SR-IOV scene, when the device physical space(such as Video
> > RAM)is fixed, as the number of VFs increases, some device driver may decrease
> > actual BAR memory space used by each VF. However, the VF BAR memory mapping is
> > always based on the usual BAR probing algorithm in PCIe spec. So do not map this
> > unneeded memory can save host memory which occupied by PTEs. Although each PTE
> > only occupies a few bytes of space on its own, a large number of PTEs can still
> > take up a lot of space.
...
> > +    /*
> > +     * Some SR-IOV device's BAR map range is larger than they can actually use.
> > +     * This extra BAR space occupy too much reverse mapping size(physical page
> > +     * back to the PTEs). So add a divisor shift parameter to resize the request
> > +     * resource of VF according to num of VFs.
> > +     */
> > +	u16 shift = 1;

Why u16??

> > +		virtfn->resource[i].end = virtfn->resource[i].start + (size >> (shift - 1)) - 1;

The 'shift - 1' may require a mask.

...
> > +struct virtfn_get_shift_methods {
> > +	u16 vendor;
> > +	u16 device;
> > +	u16 (*get_shift)(struct pci_dev *dev, u16 arg, int arg2);

More pointless u16 - they just make the code larger.

...
> > +static inline u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
> > +{
> > +	return (u16)1;
> 
> <...>
> 
> > +	return (u16)1;
> 
> Why do you need these casts? You can omit them.

Kill all the u16

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

