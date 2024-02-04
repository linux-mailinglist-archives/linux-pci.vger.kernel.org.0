Return-Path: <linux-pci+bounces-3071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E25849058
	for <lists+linux-pci@lfdr.de>; Sun,  4 Feb 2024 21:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7481F2249E
	for <lists+linux-pci@lfdr.de>; Sun,  4 Feb 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40C62511F;
	Sun,  4 Feb 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="ALaAIbcx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910F25561;
	Sun,  4 Feb 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078511; cv=none; b=jOMwaSRtWLZSZPvtgKW1IjoZRFGLpQyhsmcoCB/T8KIhIDdawvRywadxRCH4agsRW3eNubqjdWTMv4zgCkm8GUD3qIlv3xXi/3KvGYD7xJ0Nng/N0pjpc5P6vP/pJ8G4JpG5CV2UcL9p6hmvlMo0fMoP6ESRd7op+mrfhmWT6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078511; c=relaxed/simple;
	bh=RRCLSllk/dva2G67ul2MmtyLcjpVRvPRfARykcNQ2Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H5tcsNOunzn05KIB/vXR7JVsAcvXufI5GgsDlj0P0lpogZmS/OCyXzI8j+F5nc1s0nZUzvXCNsn4OnnKQSuM/RjDNafSZIv8WJ3Tfo0eaFTBS6FBk956tKbq52nMjh5lMsP1oDCFS2oD/1qrPPX4TgL2hDlGcG31+OCZ0mJhQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=ALaAIbcx reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-296855c0d71so324924a91.1;
        Sun, 04 Feb 2024 12:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707078509; x=1707683309;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZyzkVisa85tXBmaGDAlY9JwNyrAUGZi87nExzLR28k=;
        b=WVImLoxih3fLEySGm2BrO5uwPRBqd/oly2NP732rIZhLaEb+elAjPa6VP0LyHt6HBH
         CUVZ9G4XMF+hs/Du0nGZGh6KGoiSqE82SDTmDiabsd8ZS/FmWNvbfsLfm9N9H14ye4i3
         RrDtiQ2IAWJDe3hD44IkFXstqoxKycGmlBg7SzSoe28xvtHJDWw1hneTdNj9vnBmvSBK
         jmKXkX2kGnPU+CiTQFCmvGYeedEr5W/uWbIBEmAztQkkQuFOkSOBD0VhqLiWXgui2Di9
         G7LN3Oj2Vm7xH5JVppch30Ltafw2lt+7crdd0e3s/C8WNZItggfNZbCOGwebw7ExDIOj
         8qIw==
X-Gm-Message-State: AOJu0YyG63LlLUruaZnypyjXcWGFTi6wHLlJikAbrwao7yMWH96f6+JE
	DNtekY8bCrEQUTSaVQKpWLUoVzuJNwI+0wPIWGvVT6/GBEVNhGTtF5mmtCwNg5uzrw==
X-Google-Smtp-Source: AGHT+IE32prgA+85zzPEW6sOrhd9fBWgUfwAA5LQ2uAbi9+DCSuJyhy7UzWrtayKsN8EqHoTlx3faQ==
X-Received: by 2002:a17:90b:1283:b0:296:4188:10f1 with SMTP id fw3-20020a17090b128300b00296418810f1mr5604863pjb.7.1707078509537;
        Sun, 04 Feb 2024 12:28:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUeNGgYx9QfQ/v0FzSyhM5876GqlTTI4bi03Fw7oTwBz7X4cSslm6/PRhwaAget4SS4ZPv+qtDqaMUzRv+C0d2X3onlDlkXhiDqr5afsTDbeGzfsT4Y60UkfnCuty53v7jMkYpl/JCHyhzXeDatGApRW/UML4GtK5lZ26DTtSYcbEUlREsNbEJwIuB8SiAAagHg7FhumiWRJNvvfCqFRK+y8HDRq6nbLyKAAYhEDckhCMOKUuEb69zYxwD/gGGgFpM=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a898500b00295fac343cfsm3692160pjn.8.2024.02.04.12.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:28:29 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707078507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZyzkVisa85tXBmaGDAlY9JwNyrAUGZi87nExzLR28k=;
	b=ALaAIbcxjDxefM7vgoumnBR4vqsaVCwGPs1yRdo6leEP16Ah6qa0mPHpAbbpHKCU/9ulu0
	4AhKX9EAfwuhRX+KLWapezYOPb2Z1Xi2/PNdjNXscYW3OPcXY4siH/2/VCyaQ9fJrgeK/p
	AzhClPqK2i6z3QpE/xvl59zH0Z4uwjcu7IXasJPxum0ZB1G6hsJOUk+vjT+3UIqczIxZVo
	k8xWGq2VItde3+CMlTg7wWKK7dBxGokZ3oQ5WGh5OjIxQQXf07AUpJYKGe3wN8RV/YnGJJ
	1qD5XrFe7raTjlp7RfiZDhtnx6x834PgUm/X7O0QnY9AvJaDvNb7TiMHlykUVA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:28:58 -0300
Subject: [PATCH] pci: endpoint: make pci_epf_bus_type const
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-pci-v1-1-300267a1e99e@marliere.net>
X-B4-Tracking: v=1; b=H4sIAInzv2UC/x3MTQqAIBBA4avErBNMrKCrRIQ/Yw2EiYMRRHdPW
 n6L9x5gzIQMU/NAxouYzljRtQ243cQNBflqUFJpqaQWtvDqDjSxJJEciTBKO/je9NYFqFXKGOj
 +j/Pyvh/oZwPmYQAAAA==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=RRCLSllk/dva2G67ul2MmtyLcjpVRvPRfARykcNQ2Tg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/OKdIMGul4wCgFnoEfeI7KtsNOS+66/OYPmn
 tGCpi9ety6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/zigAKCRDJC4p8Y4ZY
 pjCMEACMmaS1QqpGmPkkUEdiwf23FwtT0cLiFl0ZOIvAW+4mrY7tx6a9ibnvxJ8WAtkC2nn+H5n
 XiJBRx45+FhXh+P/KW7bookQK2B0wEoWG+457jMWClv/921OdJlwWZ/Ol95AgGJAb2slVFcrHaz
 FXcWWwJM1iBUh+gBhK6Gl4ShYdjBXTDq5GSCTXW5JvHKGElpzhO0QKOSbs6RykA9fAMQg4XXqHs
 AlM5BOYVVSViE9zGSQmh5ykW4kaIiv1k/Oo2tpkwNJnMnesADE5pu2t4ygb9iH+bnkcHRJqA4gW
 4SbwWGCqoswVd4FFU2PdslQsc3rJBl2mGeBbuM1RSk44HvtIy8N1UOUwzNwnHelUkmKZwmpUWem
 B9NDRPkBPd1pFNjmtai4nepcdRCrVbEEeo6ykm766E7OS1zGsN5dJxeqxmYJXjV/N+GEgqurYyz
 dSlW3rgBkoioIXlpaHC5mppEge8j6WhOVj6yMhWhozyXnD8Eyvo2XEvYZ6piR8X5E5fXgnOPDE3
 TJJRqvp5e8e/RvKstDzbRJVTPGpNfUrncixrcLMZyZ5rHpqR4341Dtf2pEFd0AR+o/Soegl3yIZ
 cHSq1s9BGxnRQP+FCdVuhu3Qf9uQ9ncXNd1saJhJ99IMt4bWf/ZFRQX5vcU9gJpduPDDMo7sWJc
 5ELFGl7GxiIUPBA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the pci_epf_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/pci/endpoint/pci-epf-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 2c32de667937..bf655383e5ed 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -17,7 +17,7 @@
 
 static DEFINE_MUTEX(pci_epf_mutex);
 
-static struct bus_type pci_epf_bus_type;
+static const struct bus_type pci_epf_bus_type;
 static const struct device_type pci_epf_type;
 
 /**
@@ -507,7 +507,7 @@ static void pci_epf_device_remove(struct device *dev)
 	epf->driver = NULL;
 }
 
-static struct bus_type pci_epf_bus_type = {
+static const struct bus_type pci_epf_bus_type = {
 	.name		= "pci-epf",
 	.match		= pci_epf_device_match,
 	.probe		= pci_epf_device_probe,

---
base-commit: 1281aa073d3701b03cc6e716dc128df5ba47509d
change-id: 20240204-bus_cleanup-pci-f70b6d5a5bcf

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


