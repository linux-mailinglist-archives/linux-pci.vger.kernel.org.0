Return-Path: <linux-pci+bounces-8526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B9901E61
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 11:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C551C2106D
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9177A762DF;
	Mon, 10 Jun 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9yWIQ64"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB276025
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011957; cv=none; b=BkHG0x99CG7BZz4wTeSGPCKuzkxTgPE3eycFQPHItMEiHr20Hth3AzJcTo8EJhnOnT6inYGj6JnldtK0t2gUNEthVNUpThw0GhbNtmjunpp5Z0J/LRUDb5sNgigYGe07BYBpUKwpPJHRUfW9mMCvpoeZ8L8ZHFDtgMoWCA9064Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011957; c=relaxed/simple;
	bh=gbarn8HvvnKQ5tWS5o+S1lhLH3zU4Z9+rsEl0g5E/NI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k+soCoOFmb6b569Mipc7Sjq+zGE4/E2nsJrF1ZzbkXm2hGPxxPV+clwFxTjWSe6X+ZIdDWaoiC/xrEXehIKae+NQHIQGl9sKb7TXCJtWwa4azVn0gEkUupkqA20594Wadrwx0E4kQrbnMwgEsrQODRSJRtW5Z+1ESRwTG+UDxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W9yWIQ64; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eabd22d441so66620431fa.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718011954; x=1718616754; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J9eIh8+vSpsfiOQcMG0kVL21E4MR+EadTAvkQJKGVpE=;
        b=W9yWIQ64daxN/MGo3ZEYA9QPHLG66/1hHV37WGLg0D/hy24+RmyjM1i4j3dZzguPet
         XzDoUe8W5r0fTtvnHTI+cr5TmobO9o/r0GgdGz0M2EPWVhsPPLko4k97wm3jRdpCBGv8
         t7jBNPXeFlD5Gwe2+Bnn/pAELpFWTUwLpHqt0nTv9m2C6fjGWooJ6tUovjGu55yOF08S
         QiWte9dLL1RUxavMFm7OCCWSq/ILTD/G/h4ODMCv8iYfHHnFfSW8p9B6sZDdWjezbibh
         13V7M9u+dOiFFKfMW2gONN8zB+b3kY6brpwAmRgewH3NMxvUObcS1js9MR6lpoJwB5Ml
         ByvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011954; x=1718616754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9eIh8+vSpsfiOQcMG0kVL21E4MR+EadTAvkQJKGVpE=;
        b=d2oqxhjDuWz21sSdXTnkww1mgvl/6nLPsGq4ncYc5dLexVmjdIEGHOBTWn2VQRf0PT
         VB5EOZqz12UPdgV/wRvzSZ/FujRVl9gFWGiq2LbRkWTxndL0zpQ/bt7YySNX1+PwtSOm
         Ka9ZkPvlDjl0OPT8jaWkmQPJ5hijh0O6s/YklJ5NJSrFxXU62O3fcTLnNM0+MGHC4D5+
         pcvFQmQ42I0skpQTLcVOY/YsmvDa0QMya1HoDgi+rs/LQmixGhnWnhjsjPYYM/yws3Gx
         kJT6Q9hbYIpD09rBlTUrfQpydtCahPmOM7uaTRcdv/oPlCDiT9UTr4oXnBVolay/2cRU
         stQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfWVfJFieciI3oROPPYSA8vWwXDSAa+0ShejX+naBnKJ4bavsO8g+hiogcx1QqkpqYWu889kV4797ov/QNEpcwi+x2cV4I6VQ4
X-Gm-Message-State: AOJu0YzxuVkY/RNpsdOa8JpWfTxkv3eozI+JTv2F62Vk/+e5roeVjWja
	tDUpJMT8zx/6Nal1HLrBp1v358Ek1FWSP+LBM9FVcR5AASpV5a758+qZgrICLU8=
X-Google-Smtp-Source: AGHT+IH6M+gGoxYti68PgMyxeGCDfRspot0JaT6qtD4HXBifKh7SeFc6+v8ZzBU+UfXGDa7EEFw0CA==
X-Received: by 2002:a2e:82c6:0:b0:2ea:9194:ab2d with SMTP id 38308e7fff4ca-2eadce38257mr70167731fa.18.1718011953919;
        Mon, 10 Jun 2024 02:32:33 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c364bcdsm134759405e9.19.2024.06.10.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:33 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:32:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 0/2] PCI: endpoint: fix a couple error handling bugs
Message-ID: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Two small error error handling and cleanup patches.  The first one fixes
an incorrect error message printed on success.  The other one fixes some
cleanup.  Which is probably not required because PCI code is generally
required for a functioning system...

From static analysis.  Untested.

