Return-Path: <linux-pci+bounces-16449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84539C412E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 15:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2B61C21952
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23619F10A;
	Mon, 11 Nov 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAPLUC2w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9B14EC55;
	Mon, 11 Nov 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336198; cv=none; b=SwmdpLB2o0+BA2Qc2R268huL68/MD/56N6AS+SuDjsd56evFM6264GHkNMkRNc6K/83pCi4BJqvqkvISdlCQvnDFTPZJrkA0tcmfLIBAuNXGiOxSkm6vS9PttfsAEeKlNgBuef1OE55NxjslaZM5wJfWub1BG9y+MQ7l0Gjz8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336198; c=relaxed/simple;
	bh=IvgpzAjrbobQhEQYMR1QAcU4uwyiBVZfhHgYMl4JV5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHT8rUSoaLxvfqJ82wSCbk5YT6Mtc6rPrzSBaL+9KFtL/lxTWf7DPb43XI0KmIcbNEJMJa4DSWJb4FcCZMuq4j36UMYAZh/HYNbyK8+nZazx2MZv5Y3oOZjZAKfzGy/5idJGk/cGK6Dlxk4V4FQaHWWyy0PN7D0xQJiwayjHcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAPLUC2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC22DC4CED5;
	Mon, 11 Nov 2024 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731336197;
	bh=IvgpzAjrbobQhEQYMR1QAcU4uwyiBVZfhHgYMl4JV5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tAPLUC2wmFDUkOdXA+48dkkNBwQCz2AXPrtymXSzntSk/d84qFI8HoqdRHAhjogpq
	 GK512d1P3+miEouEyxWdcChgBIVCQEH6e4zkipex+ga2Ze+5wYakEgkCR8+yaqL8HW
	 B8Dh3L6L+GGopl7KhicGrnCapiGSgM8DJHwqBZSmtYWta5Yyb4Cp6UZHsyO6WAIrdB
	 hbonzP4Bo3oSISi0V6IuDGobeDvcPdqKnCKUhSRxajFR7Ivtqq8xzIJB7bUOrnfea/
	 8u3Y548L2IN4XhIkKRHrEEbaeST5lMivnaeKeViiZRPueNE1HpOKEy906Vio78oj7c
	 2/k/vJ7bcC1Bg==
Date: Mon, 11 Nov 2024 15:43:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v5 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZzIYAIGjHQJqR5Qt@ryzen>
References: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
 <20241108-ep-msi-v5-3-a14951c0d007@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-ep-msi-v5-3-a14951c0d007@nxp.com>

On Fri, Nov 08, 2024 at 02:43:30PM -0500, Frank Li wrote:

(snip)

> +static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
> +{
> +	enum pci_barno bar = reg->doorbell_bar;
> +	struct pci_epf *epf = epf_test->epf;
> +	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_bar db_bar;
> +	struct msi_msg *msg;
> +	u64 doorbell_addr;
> +	u32 align;
> +	int ret;
> +
> +	align = epf_test->epc_features->align;
> +	align = align ? align : 128;
> +
> +	if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
> +		align = max(epf_test->epc_features->bar[bar].fixed_size, align);
> +
> +	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
> +		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
> +		return;
> +	}
> +
> +	msg = &epf->db_msg[0].msg;
> +	doorbell_addr = msg->address_hi;
> +	doorbell_addr <<= 32;
> +	doorbell_addr |= msg->address_lo;
> +
> +	db_bar.phys_addr = round_down(doorbell_addr, align);
> +	db_bar.barno = bar;
> +	db_bar.size = epf->bar[bar].size;
> +	db_bar.flags = epf->bar[bar].flags;
> +	db_bar.addr = NULL;

Some of the code above ...

> +
> +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
> +	if (!ret)
> +		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> +}
> +



> @@ -909,12 +998,46 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	if (ret)
>  		return ret;
>  
> +	ret = pci_epf_alloc_doorbell(epf, 1);
> +	if (!ret) {
> +		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +		struct msi_msg *msg = &epf->db_msg[0].msg;
> +		u32 align = epc_features->align;
> +		u64 doorbell_addr;
> +		enum pci_barno bar;
> +
> +		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
> +
> +		ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
> +				  "pci-test-doorbell", epf_test);
> +		if (ret) {
> +			dev_err(&epf->dev,
> +				"Failed to request irq %d, doorbell feature is not supported\n",
> +				epf->db_msg[0].virq);
> +			return 0;
> +		}
> +
> +		align = align ? align : 128;
> +
> +		if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
> +			align = max(epf_test->epc_features->bar[bar].fixed_size, align);
> +
> +		doorbell_addr = msg->address_hi;
> +		doorbell_addr <<= 32;
> +		doorbell_addr |= msg->address_lo;
> +
> +		reg->doorbell_addr = doorbell_addr & (align - 1);
> +		reg->doorbell_data = msg->data;
> +		reg->doorbell_bar = bar;

... seems to be duplicated in this function.

Perhaps create a helper function so that you don't need to duplicate it.

Also one function is doing:
reg->doorbell_addr = doorbell_addr & (align - 1);

to align, the other one is doing:
round_down(doorbell_addr, align);

Which seems to be a bit inconsistent.
Anyway, if you move this to a helper, they will both use the same
way to align the address.
(May I suggest that you use ALIGN_DOWN() in the helper.)


Kind regards,
Niklas

