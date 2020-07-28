Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4F230B6F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 15:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgG1N1X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 28 Jul 2020 09:27:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:33611 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgG1N1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 09:27:22 -0400
IronPort-SDR: VSX3xX3ZfPOZbOEdTHBzh6K6MjvS8JtEE1z39/1IJTgXvrYXabw+tQTRYjDqOeMsyfNoihFRx7
 nb+5bSlTOJXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="131268976"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="131268976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 06:27:17 -0700
IronPort-SDR: JjdD5x4CQ/Ed4UrBOerz6LwPkXJOlxuttsP4cyWE1A0xvHMKRJN5W/deAbaBoE2O1Nk1fm0gzA
 tqN+BU9DqDTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="322184272"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2020 06:27:17 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 06:27:17 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Jul 2020 21:27:14 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 28 Jul 2020 21:27:14 +0800
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     'Jonathan Cameron' <Jonathan.Cameron@Huawei.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "ashok.raj@kernel.org" <ashok.raj@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 5/9] PCI/AER: Apply function level reset to RCiEP on
 fatal error
Thread-Topic: [RFC PATCH 5/9] PCI/AER: Apply function level reset to RCiEP on
 fatal error
Thread-Index: AQHWYd8JuKRT8XhezUyU1QFRnaPiOakaxSkAgAI6MYA=
Date:   Tue, 28 Jul 2020 13:27:14 +0000
Message-ID: <a79c227f0913438cb5a94dc80a075a7c@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-6-sean.v.kelley@intel.com>
 <20200727121726.000072a8@Huawei.com>
In-Reply-To: <20200727121726.000072a8@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, July 27, 2020 7:17 PM
> To: Kelley, Sean V <sean.v.kelley@intel.com>
> Cc: bhelgaas@google.com; rjw@rjwysocki.net; ashok.raj@kernel.org; Luck,
> Tony <tony.luck@intel.com>;
> sathyanarayanan.kuppuswamy@linux.intel.com; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org; Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> Subject: Re: [RFC PATCH 5/9] PCI/AER: Apply function level reset to RCiEP
> on fatal error
> 
> On Fri, 24 Jul 2020 10:22:19 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
> 
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >
> > Attempt to do function level reset for an RCiEP associated with an
> > RCEC device on fatal error.
> 
> I'd like to understand more on your reasoning for flr here.
> Is it simply that it is all we can do, or is there some basis in a spec
> somewhere?
> 

Yes. Though there isn't the link reset for the RCiEP here, I think we should still be able to reset the RCiEP via FLR on fatal error, if the RCiEP supports FLR.

-Qiuxu

> >
> > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > ---
> >  drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
> >  1 file changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c index
> > 044df004f20b..9b3ec94bdf1d 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -170,6 +170,17 @@ static void pci_walk_dev_affected(struct
> pci_dev *dev, int (*cb)(struct pci_dev
> >  	}
> >  }
> >
> > +static enum pci_channel_state flr_on_rciep(struct pci_dev *dev) {
> > +	if (!pcie_has_flr(dev))
> > +		return PCI_ERS_RESULT_NONE;
> > +
> > +	if (pcie_flr(dev))
> > +		return PCI_ERS_RESULT_DISCONNECT;
> > +
> > +	return PCI_ERS_RESULT_RECOVERED;
> > +}
> > +
> >  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  			enum pci_channel_state state,
> >  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> @@ -191,15
> > +202,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  	if (state == pci_channel_io_frozen) {
> >  		pci_walk_dev_affected(dev, report_frozen_detected,
> &status);
> >  		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> > -			pci_warn(dev, "link reset not possible for RCiEP\n");
> > -			status = PCI_ERS_RESULT_NONE;
> > -			goto failed;
> > -		}
> > -
> > -		status = reset_link(dev);
> > -		if (status != PCI_ERS_RESULT_RECOVERED) {
> > -			pci_warn(dev, "link reset failed\n");
> > -			goto failed;
> > +			status = flr_on_rciep(dev);
> > +			if (status != PCI_ERS_RESULT_RECOVERED) {
> > +				pci_warn(dev, "function level reset failed\n");
> > +				goto failed;
> > +			}
> > +		} else {
> > +			status = reset_link(dev);
> > +			if (status != PCI_ERS_RESULT_RECOVERED) {
> > +				pci_warn(dev, "link reset failed\n");
> > +				goto failed;
> > +			}
> >  		}
> >  	} else {
> >  		pci_walk_dev_affected(dev, report_normal_detected,
> &status);
> 

