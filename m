Return-Path: <linux-pci+bounces-11746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D572F954292
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 09:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB2CB22293
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D514C86131;
	Fri, 16 Aug 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwZt48UV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBDE82C8E
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792710; cv=none; b=Z+abDEwYCg51OyHZl7bwlDf8+34KY60Puh3kdSyc07hb8cuf/neEL14ki7jYvGSlUZSKxK78rGYGLkZiQLODfGwI6b+bMzhfqZGpyF7PxiyHY19rPUpdL8vcgySULdLNFTZRTYvgzD2kY9ca3CbYoRjQyu+Qp/Pvmgjj4AJLtOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792710; c=relaxed/simple;
	bh=kcwHckwk7JPYFiJqUA+xJfq8FMBOp3MJvtwdXSdhHbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVYFbWuDY1o5AUqKJLiadfU7L+CdhW39Kj5ul9kLdzyMUdbXcoYLTKfEsAG4cWFK+ktY2qhsUaRu28VbgmX6YHoNynk/31981Ep9PBpNYBekyY/k8Z1dY5cjNlnz2Il2u4vTwmiIat2/sRML9jQ9lFG0mVfmQHDGpI7z5XY+tWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BwZt48UV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so1343878a12.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723792708; x=1724397508; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Yp5hMnzY0MppJ+YTjzvAfDTWaoEJOMYLebj+UdYxJM=;
        b=BwZt48UVLXUhlQbI5JfvFYkiVDfJWuBL0i3El1Wn5V8uPoxCTE+lzLJpFQI1w26ep8
         n0f1HSMzJGvUKh/U4FteRdoYnpPecxEKiudSKNsVIohrqpO2kWwZVjh0OXU0FwJPkecH
         j6LznelEWOsB5Ak84/qIK06TUOp41X1t5lFsNP13jZFl3EElRmUGtba8VuoTlepkmHXd
         +QLrrXgOC51dXo4o4C51x0qEyzkQxZ3Qfja39WmfH7pYhbitNgpA6laPF8ByROy6+nT/
         nDmz89m5Xam888WiyCN4JMHZU0mpYtNu1Zn7eW2qYEkePg3BNeOcn0X8fH6JjYUF73xv
         KC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792708; x=1724397508;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Yp5hMnzY0MppJ+YTjzvAfDTWaoEJOMYLebj+UdYxJM=;
        b=sVBtp63wPw6dkSuSh3YLWEi28Pwr6IspKr5UUDgEiOWvlCQmrBbZ3H/U/Ymdlw9Wxs
         SEyu5Xmjh3LchRv3x0CKTs/aK3a5W5p5lC5b+CKz8pLTfqUuT8d5OyZKlgQ1urUDhn0/
         wNCN6ctho8EDLQ7v+dBwUGaSkuE6UUqEX5ouzK0EsWw26HoZLKbUYnJs4MmRnTdvOB/v
         nbS+21loKVuTQylAES4DPpZHtRoue55XmZaUMzll7O8IbxXqgalcMW3Q19CXOjHrlqa1
         PYcfWr5VHfEEpwI/MRwYI+wNN4l6IeGwVME6FBUmBTg4+UZScMyFNrPSBE+gaQvPbIr0
         TrbA==
X-Gm-Message-State: AOJu0YwOmEvmyOXVaOb/0I2JI5JlK6YfptS3XAQxPYID9aPvhMm0vxEl
	wc639tsrNuYvwKkGrBiygnTCC0HjGNMJLJZL3bI0W5NA8FN8q+Y/ccT1VQPvfg==
X-Google-Smtp-Source: AGHT+IE/Ce9TzANMbRw4Oif4Tj5G9vXLEWWJGupTaGJORK1OjwraaIu/dqcDdcuoU4RkUacM7S0xiw==
X-Received: by 2002:a05:6a21:3983:b0:1c1:e75a:5504 with SMTP id adf61e73a8af0-1c904faaeefmr2746336637.15.1723792707938;
        Fri, 16 Aug 2024 00:18:27 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5229sm2056273b3a.107.2024.08.16.00.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:18:27 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:48:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 00/13] PCI: brcnstb: Enable STB 7712 SOC
Message-ID: <20240816071822.GO2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:13PM -0400, Jim Quinlan wrote:
> V6 Changes
>   o Commit "Refactor for chips with many regular inbound windows"
>     -- Use u8 for anything storing/counting # inbound windows (Stan)
>     -- s/set_bar/add_inbound_win/g (Manivannan)
>     -- Drop use of "inline" (Manivannan)
>     -- Change cpu_beg to cpu_start, same with pcie_beg. (Manivannan)
>     -- Used writel_relaxed() (Manivannan)
>   o Use swinit reset if available
>     -- Proper use of dev_err_probe() (Stan)
>   o Commit "Use common error handling code in brcm_pcie_probe()"
>     -- Rewrite commit msg in paragraph form (Manivannan)
>     -- Refactor error path at end of probe func (Manivannan)
>     -- Proper use of dev_err_probe() (Stan)
>   o New commit "dt-bindings: PCI: Change brcmstb maintainer and cleanup"
>     -- Break out maintainer change and small cleanup into a
>        separate commit (Krzysztof)
> 

Looks like you've missed adding the review tags...

- Mani

> V5 Changes:
>   o All commits: Use imperative voice in commit subjects/messages
>        (Manivannan)
>   o Commit "PCI: brcmstb: Enable 7712 SOCs"
>     -- Augment commit message to include PCIe details and revision.
>        (Manivannan)
>   o Commit "PCI: brcmstb: Change field name from 'type' to 'model'"
>     -- Instead of "model" use "soc_base" (Manivannan)
>   o Commit "PCI: brcmstb: Refactor for chips with many regular inbound BARs"
>     -- Get rid of the confusing "BAR" variable names and types and use
>        something like "inbound_win". (Manivannan)
>   o Commit "PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE..."
>     -- Mention in the commit message that this change is in preparation
>        for the 7712 SoC. (Manivannan)
>   o Commit: "PCI: brcmstb: Use swinit reset if available"
>     -- Change reset name "swinit" to "swinit_reset" (Manivannan)
>     -- Add 1us delay for reset (Manivannan)
>     -- Use dev_err_probe() (Multiple reviewers)
>   o Commit "PCI: brcmstb: Use bridge reset if available"
>     -- Change reset name "bridge" to "bridge_reset" (Manivannan)
>     -- The Reset API can take NULL so need need to test variable
>        before calling (Manivannan)
>     -- Added a call to bridge_sw_init_set() method in probe()
>        as some registers cannot be accessed w/o this. (JQ)
>   o Commit "PCI: brcmstb: Use common error handling code in ..."
>     -- Use more descriptive goto label (Manivannan)
>     -- Refactor error paths to be less encumbered (Manivannan)
>     -- Use dev_err_probe() (Multiple reviewers)
>   o Commits "dt-bindings: PCI: brcmstb: ..."
>     -- Specify the "resets" and "reset-names" in the same manner
>        as does qcom,ufs.yaml specifies "clocks" and
>        "clock-names" (Krzysztof)
>     -- Drop reset desccriptions as they were pretty content-free
>        anyhow. (Krzysztof)
> 
> V4 Changes:
>   o Commit "Check return value of all reset_control_xxx calls"
>     -- Blank line before "return" (Stan)
>   o Commit "Use common error handling code in brcmstb_probe()"
>     -- Drop the "Fixes" tag (Stan)
>   o Commit "dt-bindings: PCI ..."
>     -- Separate the main commit into two: cleanup and adding the
>        7712 SoC (Krzysztof)
>     -- Fold maintainer change commit into cleanup change (Krzysztof)
>     -- Use minItems/maxItems where appropriate (Krzysztof)
>     -- Consistent order of resets/reset-names in decl and usage
>        (Krzysztof)
> 
> V3 Changes:
>   o Commit "Enable 7712 SOCs"
>     -- Move "model" check from outside to inside func (Stan)
>   o Commit "Check return value of all reset_control_xxx calls"
>     -- Propagate errors up the chain instead of ignoring them (Stan)
>   o Commit "Refactor for chips with many regular inbound BARs"
>     -- Nine suggestions given, nine implemented (Stan)
>   o Commit "Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific"
>     -- Drop tab, add parens around macro params in expression (Stan)
>   o Commit "Use swinit reset if available"
>     -- Treat swinit the same as other reset controllers (Stan)
>        Stan suggested to use dev_err_probe() for getting resources
>        but I will defer that to future series (if that's okay).
>   o Commit "Get resource before we start asserting resets"
>     -- Squash this with previous commit (Stan)
>   o Commit "Use "clk_out" error path label"
>     -- Move clk_prepare_enable() after getting resouurces (Stan)
>     -- Change subject to "Use more common error handling code in
>        brcm_pcie_probe()" (Markus)
>     -- Use imperative commit description (Markus)
>     -- "Fixes:" tag added for missing error return. (Markus)
>   o Commit "dt-bindings: PCI ..."
>     -- Split off maintainer change in separate commit.
>     -- Tried to accomodate Krzysztof's requests, I'm not sure I
>        have succeeded.  Krzysztof, please see [1] below.
>   
>   [1] Wrt the YAML of brcmstb PCIe resets, here is what I am trying
>       to describe:
> 
>       CHIP       NUM_RESETS    NAMES
>       ====       ==========    =====
>       4908       1             perst
>       7216       1             rescal
>       7712       3             rescal, bridge, swinit
>       Others     0             -
> 
> 
> V2 Changes (note: four new commits):
>   o Commit "dt-bindings: PCI ..."
>     -- s/Adds/Add/, fix spelling error (Bjorn)
>     -- Order compatible strings alphabetically (Krzysztof)
>     -- Give definitions first then rules (Krzysztof)
>     -- Add reason for change in maintainer (Krzysztof)
>   o Commit "Use swinit reset if available"
>     -- no need for "else" clause (Philipp)
>     -- fix improper use of dev_err_probe() (Philipp) 
>   o Commit "Use "clk_out" error path label"
>     -- Improve commit message (Bjorn)
>   o Commit "PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific"
>     -- Improve commit subject line (Bjorn)
>   o Commit (NEW) -- Change field name from 'type' to 'model'
>     -- Added as requested (Stanimir)
>   o Commit (NEW) -- Check return value of all reset_control_xxx calls
>     -- Added as requested (Stanimir)
>   o Commit (NEW) "Get resource before we start asserting reset controllers"
>     -- Added as requested (Stanimir)
>   o Commit (NEW) -- "Remove two unused constants from driver"
> 
> 
> V1:
>   This submission is for the Broadcom STB 7712, sibling SOC of the RPi5 chip.
>   Stanimir has already submitted a patch "Add PCIe support for bcm2712" for
>   the RPi version of the SOC.  It is hoped that Stanimir will allow us to
>   submit this series first and subsequently rebase his patch(es).
> 
>   The largest commit, "Refactor for chips with many regular inbound BARs"
>   affects both the STB and RPi SOCs.  It allows for multiple inbound ranges
>   where previously only one was effectively used.  This feature will also
>   be present in future STB chips, as well as Broadcom's Cable Modem group.
> 
> Jim Quinlan (13):
>   dt-bindings: PCI: Change brcmstb maintainer and cleanup
>   dt-bindings: PCI: Use maxItems for reset controllers
>   dt-bindings: PCI: brcmstb: Add 7712 SoC description
>   PCI: brcmstb: Use common error handling code in brcm_pcie_probe()
>   PCI: brcmstb: Use bridge reset if available
>   PCI: brcmstb: Use swinit reset if available
>   PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets
>     SoC-specific
>   PCI: brcmstb: Remove two unused constants from driver
>   PCI: brcmstb: Don't conflate the reset rescal with phy ctrl
>   PCI: brcmstb: Refactor for chips with many regular inbound windows
>   PCI: brcmstb: Check return value of all reset_control_xxx calls
>   PCI: brcmstb: Change field name from 'type' to 'soc_base'
>   PCI: brcmstb: Enable 7712 SOCs
> 
>  .../bindings/pci/brcm,stb-pcie.yaml           |  40 +-
>  drivers/pci/controller/pcie-brcmstb.c         | 513 +++++++++++++-----
>  2 files changed, 412 insertions(+), 141 deletions(-)
> 
> 
> base-commit: e724918b3786252b985b0c2764c16a57d1937707
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

