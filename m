Return-Path: <linux-pci+bounces-30487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE77AE6117
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 11:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB227178AA5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB7E218ABA;
	Tue, 24 Jun 2025 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vWUGOrx3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAA19D084
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758334; cv=none; b=uhEqbM1UC2mwO5zeGHY+r9Bz0wM1nqpQYinJs9kptLr4S1pVcIsnpXj6PRyyBhJG2bn1WJTBsrhK+AmZ/pYAD/DOyX6BVKGo+xg+xO6jZyjLCJwFePY57iW3yvTfz1Exh4seuIMLusWbnM514Ho3KJpyoxW1PuUaOSyGH36tMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758334; c=relaxed/simple;
	bh=cDz/xKJA3GJIOOI7+QVSHUOmCq6Hr6Q9w9SxHFqR3lk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TrL7/Vs5C8Ez/2K6NgYlGONwm3e60bR/WWMF3nCTSZI46knGq9fZz4CLUsDqjX08QRNF1I6BJrDYrjIBkQ+oT7frgTv4TmJvptbu5rtaDsQGzEDc+hV90m6fM9qRUo72T5rNbX2T4nBJKLVaq3UCPERT8mNbCLbtsy+s2uGarPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vWUGOrx3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a522224582so120224f8f.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 02:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750758331; x=1751363131; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J3F16BtIk8k4/yVVBxX6JNq3pzVJe5ImT0Qp1C8rLPs=;
        b=vWUGOrx38p00T+9fyjgzj0fFHaDKYlgQn5r9+VtU2WfM5KLOYfO+8ovJXtl35Sh3zm
         7aSN2DFK8f+sInGwxrXsethKBHiMIHkNVsifcjQnOZmRqDxz8M8mooVy7Rd6TpsX5c0D
         LwOn0HHzxcfW7f/M0pYQF3ShnXKdp/UpOxP0yEqttoua/KcQtcUSPGotsiPh8qQwumFf
         rQOcAqFGUcsgQvdg8uSXLQ3KORucCbQbQnYf2VjRRvsHC3hPvCPKbiGklGeWhL3FMUs/
         GLzx7WpYb4CaxAZ+huEL/pEIKavkAjdFVi3DK0TSrzMgLrms8GHomzkddcnORS+j005g
         8NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750758331; x=1751363131;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3F16BtIk8k4/yVVBxX6JNq3pzVJe5ImT0Qp1C8rLPs=;
        b=VO+PV3b2L8xNC4pPG8irsOhAzo0Ct5rdhZwItXARrroQ3s+3ZsbV/TzQFVhpgqCbpo
         rG0sgF1cfZOS55zc62Mmhx2x/XXWipcAb2QpbDl/00AfHPZyfCOtqHLnoJ/QNkyo6AEY
         WD9lfubw1fVJGpuiXnRglGlEzbRFa3N2+D5pfcB3g7xl1hB88BViAgTy7eHqcDu+p34l
         HUQ0H21PAqw02NKP81Yj4JFPuxExdTZUqU7oH1Gk0krXwFnm3Y3dciv30vQgZj94/m4I
         yxxAVkJBbRpYhgSDPWvhKraphqb7S78fJk1Cmfeg8v9YuqKwRR9zfp7ZyT4w+UJINaWM
         xoMA==
X-Forwarded-Encrypted: i=1; AJvYcCWIP6CTD7EWpSSSs5H1APJiWcn/bj9pemJv8psXXpuw9aSigNrhdlf+mcm9pGfpzgxzzWwmu9VvAFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBD97fM9oCQBPJVgm0EpjpncbRMkOQ8hhhcAbmMuTxk49RBjQ
	r+axS0FlShfKGso17zn65EQa1TYDqQrDtCSBQjBZujjcSLIVX9FBttH/w/e8Py6PPWA=
X-Gm-Gg: ASbGncuoy6iHBk4XtGcodHZH7P7vljK4n2jolLhRnvTlI/yXlIJG4MtdmIaOx3CDRe5
	qsbZufmL8dHivwWvqLFTu9NiQaeZ07XoKCRdayHE5OoPauycvVgwyuyifiWcj1eSuY0u/+VjYpY
	nFxpmcOljaaBG9sfr0NRONxkLl3lS5qBH0EkwHYPoMzIBMHL+rv3qRGCVfo/GU/7XL+3fwByXLK
	4i97HPos2Ruq2HmM8NlYWZMumyVfbCDW3TQcdKuafDwJbGaYm33A+Wagjgi5rfzRQA+NdVBbm0y
	7MKoYLaRW0APXs6EM9utgU4+fIb46+pvASormvmexa9HoENG33+PcLN70s9bXOwTjO8onAOK
X-Google-Smtp-Source: AGHT+IEfKJ8rIR5mAmTAhZsWYAZro+s+2RnbRZh2P2aL/uoMTWVJrb/SH/ZyzpbFKtFo6/c4Y61qGg==
X-Received: by 2002:a05:6000:2807:b0:3a5:232c:6976 with SMTP id ffacd0b85a97d-3a6d12e3a8fmr9251881f8f.44.1750758330808;
        Tue, 24 Jun 2025 02:45:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:cbe8:9695:6e5f:16e4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-453646fd7aasm135856715e9.20.2025.06.24.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 02:45:30 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: kernel test robot <lkp@intel.com>, Manivannan Sadhasivam <mani@kernel.org> 
Cc: llvm@lists.linux.dev,  oe-kbuild-all@lists.linux.dev,
  linux-pci@vger.kernel.org,  Manivannan Sadhasivam <mani@kernel.org>,
  Frank Li <Frank.Li@nxp.com>
Subject: Re: [pci:endpoint/epf-vntb 3/3] Warning:
 drivers/pci/endpoint/functions/pci-epf-vntb.c:695 function parameter 'bar'
 not described in 'epf_ntb_find_bar'
In-Reply-To: <202506240711.TJdFg8To-lkp@intel.com> (kernel test robot's
	message of "Tue, 24 Jun 2025 07:49:05 +0800")
References: <202506240711.TJdFg8To-lkp@intel.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 24 Jun 2025 11:45:29 +0200
Message-ID: <1jcyatjww6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 24 Jun 2025 at 07:49, kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git endpoint/epf-vntb
> head:   a0cc6e6fd072616315147ac68a12672d5a2fa223
> commit: a0cc6e6fd072616315147ac68a12672d5a2fa223 [3/3] PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250624/202506240711.TJdFg8To-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506240711.TJdFg8To-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506240711.TJdFg8To-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>>> Warning: drivers/pci/endpoint/functions/pci-epf-vntb.c:695 function
>parameter 'bar' not described in 'epf_ntb_find_bar'

Hi Manivannan,

Sorry about that. Do you prefer a fix on top of what you have already
merged in your 'endpoint/epf-vntb' branch or a complete respin of the
series ?

-- 
Jerome

