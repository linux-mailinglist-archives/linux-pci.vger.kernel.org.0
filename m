Return-Path: <linux-pci+bounces-13699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F161A98C749
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 23:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AE81F25B04
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 21:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4D51CEAD4;
	Tue,  1 Oct 2024 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JxbUgWs/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DEE1CCEE4
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816697; cv=none; b=gBRlUf0xeBODDNJqyM+TB75vpqdEpDF+36wbqGhAq/UNJ7Vwpx2HLaBaNuLQDMr1CnOr7akKGveJcaheXycERT/NFgneyJFvUf2SAPBAZ4ia+oPLfYgywrCg2IQvvAk7pX7TYmFXbASegYadbP81sZJ6Q5LaGFWvR0PdTmQw1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816697; c=relaxed/simple;
	bh=qPyDujOFTLNSxbcnmHDSi+KZgC/UzTfXThHY/68Uscw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2a7ofXmN5+18g8jouT9jL5uiv6qp40Udd5gBkNKK47w9d0wN217T+OrXkB/F9JtVVqNfB5Q4ewpHvjewmfEPkgHAJFQL5BScEySlPtqOXSilecPqcVc6VXdYWJJ5q/2fKgKnPw/7aLzmn/9QAP2jmStqvHnt5/luflavE4MIXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JxbUgWs/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b6458ee37so42062625ad.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727816696; x=1728421496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPyDujOFTLNSxbcnmHDSi+KZgC/UzTfXThHY/68Uscw=;
        b=JxbUgWs/Mrn53vTrW9mJuJLzR4Y1avvysyrxw1FrApHxbQI1QjZIoyr4r8/8SotFTs
         yv9aZViGghRBaZ0B++k+3Nc+NvOM7qi9DYW2+N66EJ3AjUM8YOZpVlXs4mtoDjAKnmj1
         YL34V3hlPegyCZkbY45vlcV9n1kifgvvN4MK+5U9WewSxrfIG5yYdH4ABz/md+IIKV4k
         9y23L5VF6F6HJ6VRM6LbQ6GuCaGOXqZApi6vh5STT79cbL4tK0RzoF3VuBr7y5prUzGu
         p45qPuL79wRsaesIXzgV6yAG48xPPgG43yA3FJi2YxScNKGGD9Lu5d3uO5msg3rDi5zO
         1CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816696; x=1728421496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPyDujOFTLNSxbcnmHDSi+KZgC/UzTfXThHY/68Uscw=;
        b=S90m9euDS3dPxji0/zKMpB1faoqs7qV3ZNre8clOlwk+wlSRU63qMrlWyX647ve9Aq
         owkJEYzaD2Ilik992SYy91ClcGHo1Vij0wSJyIELaQizGlCVb/MAQ+RD8g7XIR+Z4R5Q
         d7NMhYtLo4jalvwZyNjZ1c4fsLk0nLGnsk1jkIg1vzt+mRJtO1WancKFYQhuHGu0WcP0
         x3aYK6fGLzKV7SA53pzExd61I/37c3gR3Q/rXu4rcE1xT7/fnucyG0DrW+FSYK7oeNF1
         Znt4uJ23zNnWtTpBFh5kf0hXC3LeyvZaIaJc6a+FAiwMxt9yFEKGoalypvMvL+E8v2/o
         v68A==
X-Forwarded-Encrypted: i=1; AJvYcCVRrV47Px6VtUZGgphSW70tnApbX1VqXSJ+NbF7Y0+0tphSsoqmQVfplku1p0YI83y357vFbJBnpbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwgGBIsldPZH52pMjqi1OCVJKuZXtFtZKalixRD93D5rM8/tH
	U6/jAizT0wfjtA4fDVa02IJDcoL9zmrXVTk2aAD7hwht4lavQPeqqLzXbahlCUxs5euFSrEDVNU
	NADE=
X-Google-Smtp-Source: AGHT+IHOCKqwJNquHm6zECkIBJWswhGFdb4YTpGgI9Bdwu0jMqj8A4NHRSk3KDE5XuPFEDX+sBe2ng==
X-Received: by 2002:a17:902:ec8f:b0:20b:6f02:b4e5 with SMTP id d9443c01a7336-20bc59ae323mr13811435ad.9.1727816695778;
        Tue, 01 Oct 2024 14:04:55 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37e37168sm73412995ad.186.2024.10.01.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:04:55 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: alex.williamson@redhat.com,
	bhelgaas@google.com,
	davem@davemloft.net,
	david.abdurachmanov@gmail.com,
	edumazet@google.com,
	helgaas@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com,
	netdev@vger.kernel.org,
	npiggin@gmail.com,
	oohall@gmail.com,
	pabeni@redhat.com,
	pali@kernel.org,
	saeedm@nvidia.com,
	sr@denx.de,
	wilson@tuliptree.org
Subject: PCI: Work around PCIe link training failures
Date: Tue,  1 Oct 2024 15:04:46 -0600
Message-ID: <20241001210446.14547-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2408160312180.59022@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2408160312180.59022@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I just wanted to follow up with our testing results for the mentioned
patches. It took me a while to get them running in our test pool, but
we just got it going yesterday and the initial results look really good.
We will continue running them in our testing from now on & if any issues
come up I'll try to report them, but otherwise I wanted to say thank you
for entertaining the discussion & reacting so quickly with new patches.

The patches we pulled into our testing:

[PATCH v3 1/4] PCI: Clear the LBMS bit after a link retrain
[PATCH v3 2/4] PCI: Revert to the original speed after PCIe failed link retraining

- Matt

