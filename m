Return-Path: <linux-pci+bounces-10951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CC593F71A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 15:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B535F1C21D85
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4214F9CF;
	Mon, 29 Jul 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4KY2sbU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280D14A0B7
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261356; cv=none; b=HVrBawxLTLGhycYipiXzlkLq+xlhC8b/gUSxEjgprsN2Wku4x8YxlZm69nfSScZaKrHanbzCHs15fKF4ghlf56f6JiG3VjezcwzH81xfVe5qbFIr5jhOwypxyC9A6Srp89zQJ9rwnj83XliG5mVOQ7Bf/xqqfSeev6H2hCeXOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261356; c=relaxed/simple;
	bh=8FsX442TrJAitQSS3/8Wi6HaPs2O4RrdmTumQLmlQb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHx1nrZF5PG9jROZSFf/GkkxYTN94Jy22Opa6WXbvp4NT6gnAPUYFruCLTybPvdnKnGLwXL4KR7PdkO5XMioMDJPHAIYsal1qdY9yWDy24szTOuqWqwH2kWyvL0VbXMcjTxkdUil8EEj9JPOH2v2a1JuPGmBgkVSxMFf+OM2f6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4KY2sbU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so14191655ad.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722261354; x=1722866154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2+5OClieG7NMsxupjTRDIrQz18pxxk1qh4xfUGzZfN8=;
        b=U4KY2sbUlQ+SfvNX06BGHJspNBXGmaQzO9G2WDUwl30n2dASLf2b/X8nOCj6Gr2m4R
         hwOCKZYPQ8R7wLbjybJ2jtwFrnHzD/YAZW/gF/khlto84BzhJRi5S7WirsgA+GBCMQVc
         1ECMTzD9/anDU7NAkiA640Cu12i32DPSXdwgyixexENmfdAeqaqawvn+gHTAmZnI4JlF
         +StNvFxrr9vxajNKnbWkv6Mr0DlhMOjf09c14B1YkmIGF1DZ6C/HlLARQGeUYENFYnAY
         kSHTDfef5ZmSK5d51YsCqV6uSdRb1S3pFDMOu4taZlEQ5ZwJH6cj9DmBJ2GlTSCac9Rd
         3UjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261354; x=1722866154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+5OClieG7NMsxupjTRDIrQz18pxxk1qh4xfUGzZfN8=;
        b=uqOop72LS1DfzaxAML5RS9VuZLMYMDBDOQNCXVAY63rgOqKyZHQnO+zFmYNXg6Bang
         wkezLXaAt5yrx5otopuCXIEf4FE2bYPmOuCqo9cp69hiK3G/prdRzu2TsHjpy55Zowcb
         5Kg9fvp6BHWHb5N4PQP+uKikgbYJbVLFza5zxqdeqgfBTXidMkYZxgnDMXag5DfXjR55
         WtZWQjXHh8KKAmhM/cXWBMiPX14TPU+xdW/pLXolFw8EYf3gpR5+MmEYVHYLy2J98P2H
         EQP84rph05QuFxOrvROrvF8Bc1Jf0/DytT1udCk/4cSdXdEWwLrJdBuxmsP0cpOmjAg+
         2Pjw==
X-Forwarded-Encrypted: i=1; AJvYcCVWK42cQbuIYWL884Dmc2XRcjK9EW5nSduIjCz3OdxnBBqtZuwB6/ChuyA/Twc9TZnw2ajhf6R1cj0KFIAeGOVozf+XtfRLdgFK
X-Gm-Message-State: AOJu0Yw6l3oDIk17l0FWui236ecfpIby/DkpgqUFxgszYaxCqXxq5FWZ
	a1Jg5yIvk/rOk0gWJosOJBFb5BSUFzKC02hxTtz36woZRph+vDlParhWnODCE8lKcvLyq9ojObw
	=
X-Google-Smtp-Source: AGHT+IEpWREOXzCfJ/w7X4EUv4bKcIueXlIPDaNU2qeXOLxxg9D0oeCWz2ilLfsq+HJr3p5t97hNzA==
X-Received: by 2002:a17:902:ea02:b0:1fd:d7a7:f581 with SMTP id d9443c01a7336-1ff047e4613mr70860035ad.7.1722261354184;
        Mon, 29 Jul 2024 06:55:54 -0700 (PDT)
Received: from thinkpad ([120.60.74.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fe9cccsm82678495ad.289.2024.07.29.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:55:53 -0700 (PDT)
Date: Mon, 29 Jul 2024 19:25:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Message-ID: <20240729135547.GA35559@thinkpad>
References: <20240729122245.33410-1-manivannan.sadhasivam@linaro.org>
 <98264d15-fb30-32e0-7eba-72b3a50347e0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98264d15-fb30-32e0-7eba-72b3a50347e0@quicinc.com>

On Mon, Jul 29, 2024 at 05:58:31PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/29/2024 5:52 PM, Manivannan Sadhasivam wrote:
> > Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
> > deinit notify function pci_epc_deinit_notify() are called during the
> > execution of qcom_pcie_perst_assert() i.e., when the host has asserted
> > PERST#. But quickly after this step, refclk will also be disabled by the
> > host.
> > 
> > All of the Qcom endpoint SoCs supported as of now depend on the refclk from
> > the host for keeping the controller operational. Due to this limitation,
> > any access to the hardware registers in the absence of refclk will result
> > in a whole endpoint crash. Unfortunately, most of the controller cleanups
> > require accessing the hardware registers (like eDMA cleanup performed in
> > dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
> > functions are currently causing the crash in the endpoint SoC once host
> > asserts PERST#.
> > 
> > One way to address this issue is by generating the refclk in the endpoint
> > itself and not depending on the host. But that is not always possible as
> > some of the endpoint designs do require the endpoint to consume refclk from
> > the host (as I was told by the Qcom engineers).
> > 
> > So let's fix this crash by moving the controller cleanups to the start of
> > the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
> > called whenever the host has deasserted PERST# and it is guaranteed that
> > the refclk would be active at this point. So at the start of this function,
> > the controller cleanup can be performed. Once finished, rest of the code
> > execution for PERST# deassert can continue as usual.
> > 
> How about doing the cleanup as part of pme turnoff message.
> As host waits for L23 ready from the device side. we can use that time
> to cleanup the host before sending L23 ready.
> 

Yes, but that's only applicable if the host properly powers down the device. But
it won't work in the case of host crash or host abrupt poweroff.

- Mani

> - Krishna Chaitanya.
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-qcom-ep.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 2319ff2ae9f6..e024b4dcd76d 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -186,6 +186,8 @@ struct qcom_pcie_ep_cfg {
> >    * @link_status: PCIe Link status
> >    * @global_irq: Qualcomm PCIe specific Global IRQ
> >    * @perst_irq: PERST# IRQ
> > + * @cleanup_pending: Cleanup is pending for the controller (because refclk is
> > + *                   needed for cleanup)
> >    */
> >   struct qcom_pcie_ep {
> >   	struct dw_pcie pci;
> > @@ -214,6 +216,7 @@ struct qcom_pcie_ep {
> >   	enum qcom_pcie_ep_link_status link_status;
> >   	int global_irq;
> >   	int perst_irq;
> > +	bool cleanup_pending;
> >   };
> >   static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
> > @@ -389,6 +392,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
> >   		return ret;
> >   	}
> > +	if (pcie_ep->cleanup_pending) {
> > +		pci_epc_deinit_notify(pci->ep.epc);
> > +		dw_pcie_ep_cleanup(&pci->ep);
> > +		pcie_ep->cleanup_pending = false;
> > +	}
> > +
> >   	/* Assert WAKE# to RC to indicate device is ready */
> >   	gpiod_set_value_cansleep(pcie_ep->wake, 1);
> >   	usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
> > @@ -522,10 +531,9 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
> >   {
> >   	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > -	pci_epc_deinit_notify(pci->ep.epc);
> > -	dw_pcie_ep_cleanup(&pci->ep);
> >   	qcom_pcie_disable_resources(pcie_ep);
> >   	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
> > +	pcie_ep->cleanup_pending = true;
> >   }
> >   /* Common DWC controller ops */

-- 
மணிவண்ணன் சதாசிவம்

