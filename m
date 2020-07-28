Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0D23105A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 19:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgG1REC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 13:04:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731406AbgG1REC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 13:04:02 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 2D6E1866C03738CB0E58;
        Tue, 28 Jul 2020 18:04:00 +0100 (IST)
Received: from localhost (10.52.121.35) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 28 Jul
 2020 18:03:59 +0100
Date:   Tue, 28 Jul 2020 18:02:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>, <bhelgaas@google.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     <rjw@rjwysocki.net>, "Luck, Tony" <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 5/9] PCI/AER: Apply function level reset to RCiEP on
 fatal error
Message-ID: <20200728180235.00006ffe@Huawei.com>
In-Reply-To: <90E63E9B-DCD3-4325-B1FC-FE5C72BA191B@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-6-sean.v.kelley@intel.com>
        <20200727121726.000072a8@Huawei.com>
        <a79c227f0913438cb5a94dc80a075a7c@intel.com>
        <90E63E9B-DCD3-4325-B1FC-FE5C72BA191B@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.35]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 28 Jul 2020 09:14:11 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> On 28 Jul 2020, at 6:27, Zhuo, Qiuxu wrote:
> 
> >> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> >> Sent: Monday, July 27, 2020 7:17 PM
> >> To: Kelley, Sean V <sean.v.kelley@intel.com>
> >> Cc: bhelgaas@google.com; rjw@rjwysocki.net; ashok.raj@kernel.org; 
> >> Luck,
> >> Tony <tony.luck@intel.com>;
> >> sathyanarayanan.kuppuswamy@linux.intel.com; 
> >> linux-pci@vger.kernel.org;
> >> linux-kernel@vger.kernel.org; Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> >> Subject: Re: [RFC PATCH 5/9] PCI/AER: Apply function level reset to 
> >> RCiEP
> >> on fatal error
> >>
> >> On Fri, 24 Jul 2020 10:22:19 -0700
> >> Sean V Kelley <sean.v.kelley@intel.com> wrote:
> >>  
> >>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >>>
> >>> Attempt to do function level reset for an RCiEP associated with an
> >>> RCEC device on fatal error.  
> >>
> >> I'd like to understand more on your reasoning for flr here.
> >> Is it simply that it is all we can do, or is there some basis in a 
> >> spec
> >> somewhere?
> >>  
> >
> > Yes. Though there isn't the link reset for the RCiEP here, I think we 
> > should still be able to reset the RCiEP via FLR on fatal error, if the 
> > RCiEP supports FLR.
> >
> > -Qiuxu
> >  
> 
> Also see PCIe 5.0-1, Sec. 6.6.2 Function Level Reset (FLR)
> 
> Implementation of FLR is optional (not required), but is strongly 
> recommended. For an example use case consider CXL. Function 0 DVSEC 
> instances control for the CXL functionality of the entire CXL device. 
> FLR may succeed in recovering from CXL.io domain errors.

That feels a little bit of a weak argument in favour.  PCI spec lists examples
of use only for FLR and I can't see this matching any of them, but then they
are only examples, so we could argue it doesn't exclude this use. It's not
allowed to affect the link state, but I guess it 'might' recover from some
other type of error?

I'd have read the statement in the CXL spec you are referring to as matching
with the first example in the PCIe spec which is about recovering from
software errors.  For example, unexpected VM tear down.

@Bjorn / All.  What's your view on using FLR as a reset to do when you don't
have any other hammers to use?

Personally I don't have a particular problem with this, it just doesn't fit
with my mental model of what FLR is for (which may well need adjusting :)

Jonathan


> 
> Thanks,
> 
> Sean
> 
> >>>
> >>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >>> ---
> >>>  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
> >>>  1 file changed, 22 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c index
> >>> 044df004f20b..9b3ec94bdf1d 100644
> >>> --- a/drivers/pci/pcie/err.c
> >>> +++ b/drivers/pci/pcie/err.c
> >>> @@ -170,6 +170,17 @@ static void pci_walk_dev_affected(struct  
> >> pci_dev *dev, int (*cb)(struct pci_dev  
> >>>  }
> >>>  }
> >>>
> >>> +static enum pci_channel_state flr_on_rciep(struct pci_dev *dev) {
> >>> +if (!pcie_has_flr(dev))
> >>> +return PCI_ERS_RESULT_NONE;
> >>> +
> >>> +if (pcie_flr(dev))
> >>> +return PCI_ERS_RESULT_DISCONNECT;
> >>> +
> >>> +return PCI_ERS_RESULT_RECOVERED;
> >>> +}
> >>> +
> >>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >>>  enum pci_channel_state state,
> >>>  pci_ers_result_t (*reset_link)(struct pci_dev *pdev))  
> >> @@ -191,15  
> >>> +202,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >>>  if (state == pci_channel_io_frozen) {
> >>>  pci_walk_dev_affected(dev, report_frozen_detected,  
> >> &status);  
> >>>  if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> >>> -pci_warn(dev, "link reset not possible for RCiEP\n");
> >>> -status = PCI_ERS_RESULT_NONE;
> >>> -goto failed;
> >>> -}
> >>> -
> >>> -status = reset_link(dev);
> >>> -if (status != PCI_ERS_RESULT_RECOVERED) {
> >>> -pci_warn(dev, "link reset failed\n");
> >>> -goto failed;
> >>> +status = flr_on_rciep(dev);
> >>> +if (status != PCI_ERS_RESULT_RECOVERED) {
> >>> +pci_warn(dev, "function level reset failed\n");
> >>> +goto failed;
> >>> +}
> >>> +} else {
> >>> +status = reset_link(dev);
> >>> +if (status != PCI_ERS_RESULT_RECOVERED) {
> >>> +pci_warn(dev, "link reset failed\n");
> >>> +goto failed;
> >>> +}
> >>>  }
> >>>  } else {
> >>>  pci_walk_dev_affected(dev, report_normal_detected,  
> >> &status);
> >>  


