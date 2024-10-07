Return-Path: <linux-pci+bounces-13900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B89922F0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 05:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E971C2200E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 03:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD404C91;
	Mon,  7 Oct 2024 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRxzPCAf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673724A08
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728271294; cv=none; b=kjKmRGAwmdIky8fTSn4xtYU9BiH9qNSJ//n8bNksUXatl24brGNs/qWbrAJhr7OXgl0auTzuUa8UF8ucVqCuzfTC5o5bXEhEZgHpMDl51SrQkLIe8WIYqOUsMnTO8Z/h9CrtCIYM/J8sP1gB9gTWOxO2mE65P0Nii0g8u/jOEIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728271294; c=relaxed/simple;
	bh=22qiIyTBAwjnwv9Yh0JXKO1zHs/7+SutTxf0y5dE2JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5geXsJbI7eEyKxwl6m14i8+x+B0WEillpzrIaQyakq+vU0sKn+fkp7MeaIs0WfZ+Kchjziv+SFwy7HdtGofzZ0RMNeLvTm6pVKPThP72A/5zQI3+arMkTR1eKN3K8YKaL7j1jR6bOZ4bqmP6Aa5m1s5DD0bW36doE9LSkyLiJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRxzPCAf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ba8d92af9so28671105ad.3
        for <linux-pci@vger.kernel.org>; Sun, 06 Oct 2024 20:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728271292; x=1728876092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwYAPxSdpQfNG1BLQ8KTvGuP6z7zaDJ5WKCEbyOMzak=;
        b=dRxzPCAfz/bzfH8ATrMEjR+4IOUdLmSNftTpQk2zw/QqSHdK6tu3cwS7xExJXM64zD
         Cmvl2HjFDm7mbLQN6c+YXUIaYdebi4nRzWgzae6qMcrpsz0g4FUKcIUO4C3V98dCrHQK
         rqddyGZuYzOGVBMhhkc3H/hjr5up1KzrtHMM8dg6TzYfjkSsl+DRuodzNQNGE0nQvxtc
         F7lXNcxQ+weUR/PATQVZx/nK5y/0sLtFNEYW1BVRYNqYpOm9te+W3649wpTfw/0X13gy
         YbwPZaLE1owlsGoqM30MNj7P1AyWsuvxTDfvPiAii4OKExZfQSTyspO9FdjLOrVNBlww
         KmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728271292; x=1728876092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwYAPxSdpQfNG1BLQ8KTvGuP6z7zaDJ5WKCEbyOMzak=;
        b=ITFoJyKueEaEBCBqkfpB41gQLC15vpanThlYyhRiD91gIHwUBUzgEt+7OKmTeDKnsK
         pAgfzpYo0oG2qYZMPxtnB7t7UVSEN3TboGbj3/UkSYDmFBjcVdh+ztrGmiTzJ0QlmhJF
         yUDgJ9+WdgZWdtFzy9OjsNA9GPpbTlHCg5LRjrg46thNKb6ZugOThS6kJomubXMa2UEd
         BhQ1cnG3mHCc/GtFI9k4tPXzid4ltBiJZK+0FCaUsakGVRunfMRHv6v1bDM6C292HXx0
         uFB9EJnYxzJmCdJVWw085ixt8rNMCWd7J6F8ALxF3rKRP1Fi1Yh4Z4LtXD84WHn1NIG/
         Bnmw==
X-Forwarded-Encrypted: i=1; AJvYcCWMMcVyyHR34OH7kuBr/SVg2fz28ex0DKT6Mh/USrMbREBRHu32LqFqZ2FQ9txIqf9gWKWHZEB2qrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH54R1UxTw4Gq/MgOR+wYo4IKgCCycyMGwSLn9B7JuqXEM7SH0
	RjcuL0RldLkxeh5Ybke1IWCFUo5GVc18eNjBp+2I2EdgMb2eRu50UUk7tgf86GRrsQxWmN+3jUh
	vhttR
X-Google-Smtp-Source: AGHT+IFCa1oJA60S5oQyo1jpOD2t8mstMnof6MAYT3q8JWv87rD5xsJdD5ONlxIML27Q+xneCnIUxA==
X-Received: by 2002:a17:903:11c7:b0:20b:b455:eb72 with SMTP id d9443c01a7336-20bfde555c3mr154319365ad.8.1728271292308;
        Sun, 06 Oct 2024 20:21:32 -0700 (PDT)
Received: from google.com (98.81.87.34.bc.googleusercontent.com. [34.87.81.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cbfaasm31086225ad.88.2024.10.06.20.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 20:21:31 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:51:23 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <ZwNTswQatCdb62FT@google.com>
References: <20241003132503.2279433-1-ajayagarwal@google.com>
 <20241004231928.GA366846@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004231928.GA366846@bhelgaas>

On Fri, Oct 04, 2024 at 06:19:28PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2024 at 06:55:03PM +0530, Ajay Agarwal wrote:
> > The current sequence in the driver for L1ss update is as follows.
> > 
> > Disable L1ss
> > Disable L1
> > Enable L1ss as required
> > Enable L1 if required
> > 
> > With this sequence, a bus hang is observed during the L1ss
> > disable sequence when the RC CPU attempts to clear the RC L1ss
> > register after clearing the EP L1ss register. It looks like the
> > RC attempts to enter L1ss again and at the same time, access to
> > RC L1ss register fails because aux clk is still not active.
> >
> > PCIe spec r6.2, section 5.5.4, recommends that setting either
> > or both of the enable bits for ASPM L1 PM Substates must be done
> > while ASPM L1 is disabled. My interpretation here is that
> > clearing L1ss should also be done when L1 is disabled. Thereby,
> > change the sequence as follows.
> > 
> > Disable L1
> > Disable L1ss
> > Enable L1ss as required
> > Enable L1 if required
> 
> I think we also write the L1.2 enable bits in PCI_L1SS_CTL1 in
> aspm_calc_l12_info() when ASPM L1 may be enabled:
> 
>   pcie_aspm_init_link_state
>     pcie_aspm_cap_init
>       pcie_capability_read_word(PCI_EXP_LNKCTL)
>       aspm_l1ss_init
>         aspm_calc_l12_info
>           pci_clear_and_set_config_dword(PCI_L1SS_CTL1, PCI_L1SS_CTL1_L1_2_MASK)
> 
> That looks like another path where we should make a similar change.
> What do you think?
>
I agree. We should make a similar change there. Thanks for pointing out.
Will make the change in the next version.
> Bjorn

