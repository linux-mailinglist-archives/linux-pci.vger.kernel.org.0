Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC325B66A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 00:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBWYw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 18:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIBWYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2020 18:24:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA5C061245
        for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2020 15:24:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so452975pgl.4
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2020 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gks7VBncJdw+WEYIJpin5b0Vn3cDDCUp/XGRjCJtoEA=;
        b=zs9rHk875AEsaUsSgG6fSNEXyuD6NuAKMA9lJlRYXXtCqxr4jUqgwH59Ss+E18gNhT
         nJlNEXvfVjk8YJVsc9CT/KCk2E+spamEr9goOnxdg4hDYF96bEkxuFexkcJ0cUGss6iE
         wD13GJvauZIDtfmyqLnkX42L9pZRgKY+9qaMPzjlkwb52jCiMqa6pIjjsU8cyGYUd3Fe
         khEPLkCqf7TvImeFGTr6Qbo51euWmq325t/2yEoCBVQ5Olfnmvi+/mKVgk7iA67ttAgG
         k9tqFrxTAeFEJRouEyzX++h5CwSksToADhA8Eu+4iO1pqql7HylSa7It+hasj1oWlhUl
         /H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gks7VBncJdw+WEYIJpin5b0Vn3cDDCUp/XGRjCJtoEA=;
        b=QF1GF28cQP3JMWrRR2WW6hn98xtDNfF6fSTdXwS5Y0i7a6PvC/iiwr8yWezvtOe4Oj
         pZsYf9iVwuexuuPvRKBqf5HDx7zdOFPyxsLtYF9K4wtBrgyUYm6ekkNn3ADr1Qtyhcme
         AZQEmWGFkOqeLMkjRtOall6B8eJN/h9w/LAdRY2wfm9n16T6rdIA1e2zzX2DJFxhiOxE
         B7BvRs+WW7OvUQEx3UhetM3uYHnRogXqoYe+m7FPiphE4Wo9kqnKzFvd2JNi7MIv0C7O
         56A7WegqlaQDhzKuE3tKtlrhLYpxinYeLCgJ84CyzBY98nfG9SG7Fto90mpe6ohqlu7W
         HJPw==
X-Gm-Message-State: AOAM530ETSz2DLKR4R0hKUQnQVPbZ9/4IQGyhsTmIUXT9dbRppHL2Bl0
        FKdhI3JAcQVSha/ZtuA+bs+9hg==
X-Google-Smtp-Source: ABdhPJz5OMYhyxpIsYxNil+eT1ZISABxJxJKYLCweCZ2+ndS76mtmW6s3xt125xdQqqGoUFVTOXTvg==
X-Received: by 2002:aa7:989e:: with SMTP id r30mr521567pfl.205.1599085490270;
        Wed, 02 Sep 2020 15:24:50 -0700 (PDT)
Received: from arch-ashland-svkelley ([2601:1c0:6a00:1804:88d3:6720:250a:6d10])
        by smtp.gmail.com with ESMTPSA id a26sm545929pfn.93.2020.09.02.15.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:24:49 -0700 (PDT)
Message-ID: <680ae97e3424b50454ed773ad2e5e610e6fc5d9c.camel@intel.com>
Subject: Re: [PATCH v3 07/10] PCI: Add 'rcec' field to pci_dev for
 associated RCiEPs
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Sep 2020 15:24:08 -0700
In-Reply-To: <20200902163504.GA254301@bjorn-Precision-5520>
References: <20200902163504.GA254301@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, 2020-09-02 at 11:35 -0500, Bjorn Helgaas wrote:
> On Wed, Aug 12, 2020 at 09:46:56AM -0700, Sean V Kelley wrote:
> > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > 
> > When attempting error recovery for an RCiEP associated with an RCEC
> > device,
> > there needs to be a way to update the Root Error Status, the
> > Uncorrectable
> > Error Status and the Uncorrectable Error Severity of the parent
> > RCEC.
> > So add the 'rcec' field to the pci_dev structure and provide a hook
> > for the
> > Root Port Driver to associate RCiEPs with their respective parent
> > RCEC.
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -202,6 +202,12 @@ pci_ers_result_t pcie_do_recovery(struct
> > pci_dev *dev,
> >  		pci_walk_dev_affected(dev, report_frozen_detected,
> > &status);
> >  		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> >  			status = flr_on_rciep(dev);
> > +			/*
> > +			 * The callback only clears the Root Error
> > Status
> > +			 * of the RCEC (see aer.c).
> > +			 */
> > +			if (dev->rcec)
> > +				reset_link(dev->rcec);
> >  			if (status != PCI_ERS_RESULT_RECOVERED) {
> >  				pci_warn(dev, "function level reset
> > failed\n");
> >  				goto failed;
> > @@ -245,7 +251,11 @@ pci_ers_result_t pcie_do_recovery(struct
> > pci_dev *dev,
> >  	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
> >  		pci_aer_clear_device_status(dev);
> >  		pci_aer_clear_nonfatal_status(dev);
> > +	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END && dev-
> > >rcec) {
> > +		pci_aer_clear_device_status(dev->rcec);
> > +		pci_aer_clear_nonfatal_status(dev->rcec);
> 
> Conceptually, I'm not sure why we need the dev->rcec link.  The error
> was *reported* via the RCEC, so don't we know the RCEC up front,
> before we even identify the RCiEP?  Can't we just remember that and
> dispense with dev->rcec?

However, we can also get errors reported by that same RCEC that are not
related to the associated RCiEPs. Further, an RCiEP in reporting an
error will trigger logging to the Root Error Command/Status and Error
Source Identification registers of the associated RCEC. The assumption
in pcie_do_recovery() here is that I can cover both scenarios.
 
In a new revision of this patch series...

        if (type != PCI_EXP_TYPE_RC_END) {
                if (pcie_aer_is_native(bridge))
                        pcie_clear_device_status(bridge);
                pci_aer_clear_nonfatal_status(bridge);
        }

I've a new revision that makes use of the earlier thread discussing
'bridge' assignment conditionally and when it makes sense to refer to
the 'dev'.

.

> 
> I'm also concerned that if we fail to identify the RCiEP (i.e., we
> don't have a valid "dev" to use dev->rcec), we will fail to clear the
> error status bits.  I think it's possible that the RCEC will report
> an
> error, but the RCiEP that generated the error message is not
> responding so we can't find it.

That's the association which is enumerated at boot by BIOS either
through the bitmap or through the next/last bus range. Are you
describing a scenario in which during enumeration of the RCECs/RCiEPs
the relationships are not discovered?

The second bit you describe is where the error is reported and the
RCiEP is not responding. I wonder if that will eventually trigger an
error from the RCEC.  But you are right such a scenario could happen so
you are getting the error but the device is not present or may not even
have been present from BIOS perspective?

Sean


> 
> >  	}
> > +
> >  	pci_info(dev, "device recovery successful\n");
> >  	return status;
> >  
> > diff --git a/drivers/pci/pcie/portdrv_pci.c
> > b/drivers/pci/pcie/portdrv_pci.c
> > index d5b109499b10..a64e88b7166b 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -90,6 +90,18 @@ static const struct dev_pm_ops
> > pcie_portdrv_pm_ops = {
> >  #define PCIE_PORTDRV_PM_OPS	NULL
> >  #endif /* !PM */
> >  
> > +static int pcie_hook_rcec(struct pci_dev *pdev, void *data)
> > +{
> > +	struct pci_dev *rcec = (struct pci_dev *)data;
> > +
> > +	pdev->rcec = rcec;
> > +	pci_dbg(rcec, "RCiEP(under an RCEC) %04x:%02x:%02x.%d\n",
> > +		pci_domain_nr(pdev->bus), pdev->bus->number,
> > +		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> 
> If we do need dev->rcec, this should use pci_name() for the second
> device instead of formatting the name manually.  I think I would
> connect this with the RCiEP instead of the RCEC, e.g.,
> 
>   pci_dbg(pdev, "PME & error events reported via %s\n",
> pci_name(rcec));
> 
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * pcie_portdrv_probe - Probe PCI-Express port devices
> >   * @dev: PCI-Express port device being probed
> > @@ -110,6 +122,9 @@ static int pcie_portdrv_probe(struct pci_dev
> > *dev,
> >  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
> >  		return -ENODEV;
> >  
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> > +		pcie_walk_rcec(dev, pcie_hook_rcec, dev);
> > +
> >  	status = pcie_port_device_register(dev);
> >  	if (status)
> >  		return status;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index c7fc5726872c..ba29816c827b 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -330,6 +330,7 @@ struct pci_dev {
> >  #ifdef CONFIG_PCIEPORTBUS
> >  	u16		rcec_cap;	/* RCEC capability offset */
> >  	struct rcec_ext *rcec_ext;	/* RCEC cached assoc. endpoint
> > extended capabilities */
> > +	struct pci_dev	*rcec;		/* Associated RCEC device
> > */
> >  #endif
> >  	u8		pcie_cap;	/* PCIe capability offset */
> >  	u8		msi_cap;	/* MSI capability offset */
> > -- 
> > 2.28.0
> > 

