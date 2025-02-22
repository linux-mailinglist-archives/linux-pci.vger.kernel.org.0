Return-Path: <linux-pci+bounces-22115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A711A40ABB
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4017E391
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8413E40F;
	Sat, 22 Feb 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2WPbG6W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F62AEFB
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740246044; cv=none; b=ZsaEVxFLlIWqE8nKLsUbeSTOffmYrccKn9On3MOClkUVh6Io2WbZWF5pTJecvf9Q05wgTosmBTVQzRounRuYSrpI+wmPWE4WmiUWPSMmPpXiVxUkDeyrJfC66aiC4e1g1WStU/FCh4HOWhk5eCp2/u4J6xtA/YtyyDLx161cMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740246044; c=relaxed/simple;
	bh=vFPBwWWyHXkt1kePmjCNxHCOik1ni96943leozSw/uY=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=WhEGLKVrMT3bPhyiYSFV/a5lMNOKhEz0CucY2JCmnju0XmhKaDJqxm/4fjxjmeqE2FcXv43DTs+PmUJYOY6PVOzetIXsr0nZEhVE7gdy25I5aAQKg1V1T15Cbeeh9anc+gjb6WGSdzQpcPu5jzVOsYKL8lw+WnBp1qPdFx8lxyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2WPbG6W; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f325ddbc2so2308071f8f.1
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740246040; x=1740850840; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:autocrypt:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1ttL5pHI1p713eH7OoYs5qTbz5rBQ8zpC4b19SPCFU=;
        b=m2WPbG6WToNPMwywY0bsLWPWSknRYd/TkVBk++ED1PVqQ69yM5Rwd384mQKtPuDCIN
         K83rIxu2eRuIGnpGllh+VUoYnSm1EXM9qKhJezkNqkOvc7cqh4bS71f5dsuHOId7hjzi
         wdIduX1Vxyp2IzO5LorA6s7KlpCFk49D3YZu7moyFFh8QnJ8NdIeo2RwwSymhM/lfhjI
         8K9iL8jSltwjTZJH+ulZwpNwzo11nJK44CycmRD8Ghc8dYKeFvYnfcxeElqG5j1rsCqP
         sz0a8PLFZFP9zPYo+9B0I+jIcqsFa3ejDKRLTAQZHXX49V7RflOr88Nao6/sABixZoWJ
         Oj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740246040; x=1740850840;
        h=content-transfer-encoding:subject:cc:to:autocrypt:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F1ttL5pHI1p713eH7OoYs5qTbz5rBQ8zpC4b19SPCFU=;
        b=hwwhRblFZf9ng24tUtPC3A4cy5pp7zu2LK7HSqRXI124yMSLhETATjOteRtt91ODYv
         3xBYsI/3URRxDTUOh1oSAzb5ixCmtOr+36ce3wHMXNfq7bcU2tgsGNxEAccCpqkGS047
         A7/c0J2fNerifOETW5rUXzbjlI0W1GbcD2aUcJDIv71Jq8+hi0+TElpnBnYJDR4h9OSr
         +sJ+dimsWkOwgsEEE9/YhJRZ8WYCuRd+suLCCV5NgpI4T8hTn3AoPLb+7zcb49b63BmH
         XdbdsP7zC0bNpYoH6oNHLmi1sAmU1X4AHw5fCSt/oDGXZIMInaOru03My2ZanLhgJoeo
         1oIg==
X-Gm-Message-State: AOJu0YyZN4l2gUTou6BISmi4H3P3wCxLL8PO69cEtL5Z4E27BirUmASA
	YnIMzMv0A5jTAfQ6OtHeQdw36UQpkY4DV2uB54p5ADnDuRvJhYvpk2r+8IoK
X-Gm-Gg: ASbGncs829ZHtmuGxuTcLbKVlW58mrh8ThEpsFlG+xjXNVpywdmMfOTA98fzqwXH0Tb
	pGHRi7UPZwXWGlXGsnXK0py65Bx1wDHaBhvUOhiVh96x+YHnualX+GGEjDCcjf6Kuaa8lsraAxb
	1//hPnQOkS9NsO2GYXfGkZ6/luCm14hn1NvlHt0e2oOsNFj2onTzuvdRzSdTLA+xpCqqxykZ5qn
	gnYkCZGgFXehhXRXiKHNeGMF8txfTdS384I34WMAdNILq42LOJFFibCuMK754gHx/xnZTozRNYS
	lNEGP2ohvq+e/abPkWw5hePNezGf0TwWxX9Nt6sJgwBhHvFDTdv/a4S+ooeJJBQsD7Um/aDuDG7
	nXlN5u8RvTbSEUbFSqhSXCgzCJrhmgB+A5uC6rdH6qyb5Jm2R8czDTmnlxrhDICw+Yna41R7tPq
	S/YSseqEHuPKSFMNZs2g==
X-Google-Smtp-Source: AGHT+IG/QR9+S1hGghueMFFW+x8PcwPifBvebaXQ+uFfS3ddt6rIymhObJltwL2SgEH+8hGe1v/FPA==
X-Received: by 2002:a5d:6c63:0:b0:38f:2a7f:b6cd with SMTP id ffacd0b85a97d-38f7079a134mr5334761f8f.20.1740246039698;
        Sat, 22 Feb 2025 09:40:39 -0800 (PST)
Received: from ?IPV6:2a02:3100:a1a4:5e00:9561:7632:4077:4896? (dynamic-2a02-3100-a1a4-5e00-9561-7632-4077-4896.310.pool.telefonica.de. [2a02:3100:a1a4:5e00:9561:7632:4077:4896])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f258dab74sm27112460f8f.32.2025.02.22.09.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 09:40:39 -0800 (PST)
Message-ID: <cd2859a2-693f-4de7-ba4f-351b1dbd0d69@gmail.com>
Date: Sat, 22 Feb 2025 18:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Frank Min <Frank.Min@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>
Subject: Wrong LTR-related check in nbif_v6_3_1_program_ltr()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In nbif_v6_3_1_program_ltr() (and maybe other functions as well) you have
the following:

pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);

if (adev->pdev->ltr_path == (devctl2 & PCI_EXP_DEVCTL2_LTR_EN))
	return;

if (adev->pdev->ltr_path)
	pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
else
	pcie_capability_clear_word(adev->pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);

The comparison to (devctl2 & PCI_EXP_DEVCTL2_LTR_EN) looks wrong, as this expression
can only be 0 or 0x400. I think what you want is
if (adev->pdev->ltr_path == !!(devctl2 & PCI_EXP_DEVCTL2_LTR_EN))

In general I wonder whether the code part is needed and why pci_configure_ltr()
in PCI core isn't sufficient for you.


