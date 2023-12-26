Return-Path: <linux-pci+bounces-1385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3868F81E2FC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 01:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE2A1C20CF3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 00:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E9D36E;
	Tue, 26 Dec 2023 00:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="f5S6r3I3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00011E49D
	for <linux-pci@vger.kernel.org>; Tue, 26 Dec 2023 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so660910a12.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Dec 2023 16:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1703548980; x=1704153780; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2hfvv+swjba6mg+pRtlk7kiaUfMDuo3bGE0uQDlvTgI=;
        b=f5S6r3I3/noj/iAPi8FPcSr7LDzd5Ag009shMGwlzM7IZuyiGlasLW/c3k7ymeF8r/
         Sl+qzh4DY50J78rlPBf9cMKyxwxPG3LpsogrmkWDICxsklQIFeZU23BlHupWXiehyIh7
         uVXJ7slLpkrqyi5UYVa6Rklk++vBGeIv8e4NqaI5q7N2x37cL+O6JbQ1DZk766ONibCF
         Wpo+2vPrmVgva24+SbBz9gdtf7Jp/EkQIrQD65+9l+xDeDwB/MOA0hEp3i2oYM4vELIs
         GeC4xoVr3H+GiQQ60tlkgLxwKvfW/3lG8qVfqhy2ifKXW6GSoN1g9Jd+eOWkmLl5c5k0
         QYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703548980; x=1704153780;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hfvv+swjba6mg+pRtlk7kiaUfMDuo3bGE0uQDlvTgI=;
        b=BQr692VV8mN+Q3wCa2RUkOTdwYHQzP+UOqGCoYmw7b43YDN5lBG3M4KX2dNrYG5kYk
         1hg13+VLsNBOFV2UeyLMU3gGcQQ0+fh7ipsxZ7ZuETcHU1v1rkPFwevinBXccNwYEnYN
         A//iuDgckt7Ek9sIlmW2lUWJtD650hJ3YWQ6145GUdHhrlzjv/j7vUAvQqIyQtuEr5Z+
         i86KjvPwgYdg1J8JhHkiyD9O6ntGYPAhpD8TCxae2F+VgIGiujNPYqcXW7XAPaMRvSEY
         SV6CGwoir4fDwdyYaHvEzUb3dP5Fzl0wmWoKGTsHjKV2iDDmwWQOuSVqvOvahxH94Fbc
         mF6w==
X-Gm-Message-State: AOJu0YwIWn43WCbdd5dAldH95Scg75E5/pVgbqxGIptvsLO5ljgK7yIk
	gdfTtv+VQDKHAnIHefjBhYdO45Uj+R63zQ==
X-Google-Smtp-Source: AGHT+IHn/FZCRK+EMtS92euiGxoVA3cXvrwT2tA9UAJLzNKOBroWCsL2sDSJFHdfeo7sg5N2nJB6/w==
X-Received: by 2002:a17:90b:4b07:b0:286:6cd8:ef07 with SMTP id lx7-20020a17090b4b0700b002866cd8ef07mr7853048pjb.31.1703548979636;
        Mon, 25 Dec 2023 16:02:59 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id y31-20020a17090a53a200b0028649b84907sm14082296pjh.16.2023.12.25.16.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 16:02:59 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: lkp@intel.com
Cc: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	llvm@lists.linux.dev,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	oe-kbuild-all@lists.linux.dev,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER natively.
Date: Mon, 25 Dec 2023 17:02:51 -0700
Message-Id: <20231226000251.3182-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202312260431.ZXppQZ1I-lkp@intel.com>
References: <202312260431.ZXppQZ1I-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

I guess we don't build aer_cap into pci_dev without CONFIG_PCIEAER...
Wonder if I should just drop the check for aer_cap since its likely
not necessary anyways.

