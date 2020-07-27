Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39022E9E8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 12:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgG0KWr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 06:22:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727813AbgG0KWr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 06:22:47 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 58BA1E7371DCCA907CA0;
        Mon, 27 Jul 2020 11:22:45 +0100 (IST)
Received: from localhost (10.52.121.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 11:22:44 +0100
Date:   Mon, 27 Jul 2020 11:21:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@kernel.org>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 1/9] pci_ids: Add class code and extended capability
 for RCEC
Message-ID: <20200727112121.00007653@Huawei.com>
In-Reply-To: <20200727110010.00005042@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-2-sean.v.kelley@intel.com>
        <20200727110010.00005042@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.176]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 27 Jul 2020 11:00:10 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 24 Jul 2020 10:22:15 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
> 
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > 
> > A PCIe Root Complex Event Collector(RCEC) has the base class 0x08,
> > sub-class 0x07, and programming interface 0x00. Add the class code
> > 0x0807 to identify RCEC devices and add the defines for the RCEC
> > Endpoint Association Extended Capability.
> > 
> > See PCI Express Base Specification, version 5.0-1, section "1.3.4
> > Root Complex Event Collector" and section "7.9.10 Root Complex
> > Event Collector Endpoint Association Extended Capability"  
> 
> Add a reference to the document
> "PCI Code and ID Assignment Specification"
> for the class number.

Actually probably no need. I'd somehow managed to fail to notice the
class code is also given in section 1.3.4 of the main spec.

> 
> From the change log on latest version seems like it's been there since
> version 1.4.
> 
> There is a worrying note (bottom of page 16 of 1.12 version of that docs)
> in there that says some older specs used 0x0806 for RCECs and that we
> should use the port type field to actually check if we have one.
> 
> Hopefully we won't encounter any of those in the wild.
> 
> Otherwise, it's exactly what the spec says.
> We could bike shed on naming choices, but the ones you have seem clear enough
> to me.
> 
> FWIW
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 
> Jonathan
> > 
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > ---
> >  include/linux/pci_ids.h       | 1 +
> >  include/uapi/linux/pci_regs.h | 7 +++++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 0ad57693f392..de8dff1fb176 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -81,6 +81,7 @@
> >  #define PCI_CLASS_SYSTEM_RTC		0x0803
> >  #define PCI_CLASS_SYSTEM_PCI_HOTPLUG	0x0804
> >  #define PCI_CLASS_SYSTEM_SDHCI		0x0805
> > +#define PCI_CLASS_SYSTEM_RCEC		0x0807
> >  #define PCI_CLASS_SYSTEM_OTHER		0x0880
> >  
> >  #define PCI_BASE_CLASS_INPUT		0x09
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index f9701410d3b5..f335f65f65d6 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -828,6 +828,13 @@
> >  #define  PCI_PWR_CAP_BUDGET(x)	((x) & 1)	/* Included in system budget */
> >  #define PCI_EXT_CAP_PWR_SIZEOF	16
> >  
> > +/* Root Complex Event Collector Endpoint Association  */
> > +#define PCI_RCEC_RCIEP_BITMAP	4	/* Associated Bitmap for RCiEPs */
> > +#define PCI_RCEC_BUSN		8	/* RCEC Associated Bus Numbers */
> > +#define  PCI_RCEC_BUSN_REG_VER	0x02	/* Least capability version that BUSN present */
> > +#define  PCI_RCEC_BUSN_NEXT(x)	(((x) >> 8) & 0xff)
> > +#define  PCI_RCEC_BUSN_LAST(x)	(((x) >> 16) & 0xff)
> > +
> >  /* Vendor-Specific (VSEC, PCI_EXT_CAP_ID_VNDR) */
> >  #define PCI_VNDR_HEADER		4	/* Vendor-Specific Header */
> >  #define  PCI_VNDR_HEADER_ID(x)	((x) & 0xffff)  
> 


