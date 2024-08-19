Return-Path: <linux-pci+bounces-11802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D8A956646
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0622A283324
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 09:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB615B980;
	Mon, 19 Aug 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKi5CySM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E30B15B966;
	Mon, 19 Aug 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058273; cv=none; b=rz+582dZxz6efHMojEEHKUN0jgOURuyk3nmT1YnhbNjkEtU2GFjWpTNm/4J99ATGw9YKKsyYABh63Xt7ua1cYRPNQvLiVFhRFBsd9rMz4lRI8eikx+sKFToyar0AAJuYDhiag8/tzyCWrihk4iIfjMMChp9X2Ilz+qzC6XAIfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058273; c=relaxed/simple;
	bh=9KeAJ85mARaA164U631pYrL0Sb6s2xqY74y27QZM7sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMi5mBgVDUvRVHknNgWDFXb44ojCtjcCrH+IOCL1UnzFu9rhV82CRlQOVqFeMGR+z/LlpXgLb/OGi3u12wETBqAh67dUTRSbkSeWUxOuh8Hpr1lmInOkMHzYfWTvL+CGT3TDE2UlSk9rMLNg1SwKZ9ZLZdSXGOx2xOVr9nsC3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKi5CySM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36d2a601c31so2393915f8f.0;
        Mon, 19 Aug 2024 02:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724058270; x=1724663070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CYk/Np4BRVvjkNNwkVfXEx5Cn133dtofexIhTAAA2fo=;
        b=CKi5CySMt/hRLGHwcm2MBSGTvkEvDlV1byJjxfd7zEA3IQQctpSolq/o04lVN05OTh
         kmPb2dJsYxJFRrHQcPqIm5w0vDhYtJsqDVaCOFIasRB+k3Jpl68/VVFRHCN+1PBuPOrA
         1WiCyFOpx5Moa6aFPbq9S0bnVJZs+GnkicIakgL7WhP0PmCEHUQ6sGNDfLvPYCWoTrw+
         B6tK9VtkfI1hJOpDtqj6XmIuLh2W23+qcrRH+ZPBkyl7wrRiq658J4mz5btfUQEu8Gjm
         liJVXwdfyZ7jKNJbXLeR4gPOMzuQSM98eS4JP8VCNHjUhkfbtvcncQ4RyayioiaUYy9q
         4isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058270; x=1724663070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYk/Np4BRVvjkNNwkVfXEx5Cn133dtofexIhTAAA2fo=;
        b=TBkRO4xHX+JYJGb6n29TiQFsHytqV60jcBEFIWt0GXzaeeQ3m3G/EY9dPB+vNospJT
         uCk6z7zlWG3GHXSuPKYx0v4bFRVrHtfGebIdJUYC19Fxe9PboD46VzLC7w2DXNBmQu+I
         1Pm5Zu4KAgf5JBvwD1qcmU/Pne9qLLaMVgjXdubB+bET/knS3x74TwpKV4R0IQrmUDNJ
         baEdgdFceArECUlG4EK+p4GXZR+hh1FlVoVsUbateW5ZIC3+2amY1Ix5Xnxf6bSyh+3z
         fbDlwvLa+LwBZq7IlCd8eVt3/3alPWg4gGV3EX2fUO7qYM3UotP3G+Baqc8tJVgNb9Of
         BV8A==
X-Forwarded-Encrypted: i=1; AJvYcCXzJjfMseS6ZkDLRJaXJL9uuEK2cXBQvb9cDUN4rj1FQO6k79teyWRAyq8fps6u4gIFqeV3jjKVhDcAbiSwGCrFjgOyEUUuwcXvjznQ
X-Gm-Message-State: AOJu0YzGQg6mw29ORPyOCflTK1GJWH1aZWRsziYADBvdyD7b8nw0zK6P
	lVaEn3Ato2lq7fxebbbWmNY5UHPvyec37MvKxhE3l+k9MnvJ24ed
X-Google-Smtp-Source: AGHT+IEbU1HgO/yej+WfZeaZhOMIw5v7VLZzInmznYjHixqxo9k1PPUaTG3RO3a5m4gtSHIAvWU/XQ==
X-Received: by 2002:a5d:5e0f:0:b0:367:4d9d:56a5 with SMTP id ffacd0b85a97d-371983d5ea0mr4843461f8f.44.1724058269951;
        Mon, 19 Aug 2024 02:04:29 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:a64c:8731:e4fb:38f1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19627sm154672095e9.5.2024.08.19.02.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 02:04:29 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] PCI: imx6: reset link after suspend/resume
Date: Mon, 19 Aug 2024 11:03:16 +0200
Message-ID: <20240819090428.17349-1-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the i.MX6Quad (not QuadPlus), the PCIe link does not work after a
suspend/resume cycle. Worse, the PCIe memory mapped I/O isn't accessible
at all, so the system freezes when a PCIe driver tries to access its I/O
space. The only way to get resume working again is to reset the PCIe
link, similar to what is done on devices that support suspend/resume.
Through trial and error, we found that something about the PCIe
reference clock does not work as expected after a resume. We could not
figure out if it is disabled (even though the registers still say it is
enabled), or if it is somehow unstable or has some hiccups. With the
workaround introduced in this patch series, we were able to fully resume
a Compex WLE900VX (ath10k) miniPCIe Wifi module and an Intel AX200 M.2
Wifi module. If there is a better way or other ideas on how to fix this
problem, please let us know. We are aware that resetting the link should
not be necessary, but we could not find a better solution. More
interestingly, even the SoCs that support suspend/resume according to
the i.MX erratas seem to reset the link on resume in
imx6_pcie_host_init, so we hope this might be a valid workaround.

Stefan Eichenberger (3):
  PCI: imx6: Add a function to deassert the reset gpio
  PCI: imx6: move the wait for clock stabilization to enable ref clk
  PCI: imx6: reset link on resume

 drivers/pci/controller/dwc/pci-imx6.c | 69 +++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 10 deletions(-)

-- 
2.43.0


