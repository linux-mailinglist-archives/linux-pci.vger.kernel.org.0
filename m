Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA217E49E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 17:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCIQTw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 12:19:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:39178 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbgCIQTw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 12:19:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 09:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; 
   d="scan'208";a="230981052"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2020 09:19:51 -0700
Date:   Mon, 9 Mar 2020 09:19:51 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Stanislav Spassov <stanspas@amazon.com>, linux-pci@vger.kernel.org,
        Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        Rajat Jain <rajatja@google.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Message-ID: <20200309161951.GA25817@otc-nc-03>
References: <20200307172044.29645-1-stanspas@amazon.com>
 <20200307172044.29645-4-stanspas@amazon.com>
 <0461c706-579b-8c03-cf33-66e79890af92@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0461c706-579b-8c03-cf33-66e79890af92@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 09, 2020 at 11:55:11AM -0400, Sinan Kaya wrote:
> On 3/7/2020 12:20 PM, Stanislav Spassov wrote:
> > +		rc = pci_dev_poll_until_not_equal(dev, PCI_VENDOR_ID, 0xffff,
> > +						  0x0001, reset_type, timeout,
> > +						  &waited, &id);
> > +		if (rc)
> > +			return rc;
> > +
> 
> If I remember right, this doesn't work for VF sending CRS because VF
> always returns 0xffff for VENDOR_ID register.

Is this required by the PCIe spec? i think the only requirement is 
the 1s wait after PF has done the VF enable. See Implementation Note
right above section 2.3.1.1 in the Base spec 5.0. 

If this behavior is different for maybe a specific SRIOV device we should
probably quirk the standard behavior?

The rules are mentioned in so many places, but looking through the 
SRIOV section's doesn't seem to specify special rules for VF's other than
the wait time after VF enable.


