Return-Path: <linux-pci+bounces-83-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740BF7F3CBB
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 05:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8441C20E3B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 04:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348E2BAF2;
	Wed, 22 Nov 2023 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bQ+yNsMV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64ABD
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 20:24:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ce28faa92dso50314325ad.2
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 20:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700627061; x=1701231861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B+lVdDouQeSPEhAf7heDCv/PgEObW5jVExxHIuFX9Ng=;
        b=bQ+yNsMVlcG+VIsPwhW1e92azrKFEjf3II4SMFtNJSYsz6fqB+W1dxi6M/emcd1lWA
         kHxLEUg9f2UElctKv/NoFvk8TAZJ99Fv2OCjEJviAP/Zx94toAkqtoH5Y49vc8UCToLO
         FW3lYyUKoDln38LxtkLDBaFiNGIHVESVuIitcJNABlHW2bvmVGH83IyNcnKhN7IfsQr/
         POqDiyu+JZJ0gicbRn/Exy9ZxZFk39aCjKmVkFqsJF6GUN9jGGIBPmOiO8QeyBD/mMt9
         PLosmE2v4m8eqSRziRBsakSAkE2rZUa/GJmtEM4AVvgEohWWlqKSqJuusB+M5W2dRVT5
         ADKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700627061; x=1701231861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+lVdDouQeSPEhAf7heDCv/PgEObW5jVExxHIuFX9Ng=;
        b=Cs57tVgEOmLnNZQctMkV6UGSpGhQzg3aaOd9jqZirUaYIoyvj0Jk3GzS2TiwoYhon9
         w0em8Xjmnd5VqxCuGOLxYOkzdjl2Y7S8/hK/VUbhDvOqRdnRLtpcIebUDTz6gy32jAdF
         B5giPIi5uRgxGMLdnOzMwqskQL3tNzBdroPEz6uwUM6W7sDYRT0awH4cmWYg+a/I0TOS
         1Hfs4HiiUgLTNY2L8Ng2B7unuIFcuERFOsK9sZsZXpWsIM35lZiOf2or6xTpD6BSgyEU
         2egxcAQB5HCuT5LrQf6FO0dnsH8LHlfxhTxeiEtMZXCJND9RkuVZU/iZkH7zf04obgSj
         8V3g==
X-Gm-Message-State: AOJu0Yy9HP2zWSldmbJwM58r9klc+d1XWXYrDrE9AHWprIkLnwr3B2TH
	qz+/dDIRcHMeLkHGibx/jfvCVA==
X-Google-Smtp-Source: AGHT+IHDf07++XYjYmAtDWtjKrHuMHQMsmmhUh0KqJmC3+i7vQDyGQzo8CAhVyYcYtjOcc4nSHsU0A==
X-Received: by 2002:a17:903:483:b0:1cc:51b8:8100 with SMTP id jj3-20020a170903048300b001cc51b88100mr1210569plb.7.1700627061065;
        Tue, 21 Nov 2023 20:24:21 -0800 (PST)
Received: from dns-b876885-0.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001c61901ed37sm8773684plb.191.2023.11.21.20.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 20:24:20 -0800 (PST)
From: Daniel Stodden <dns@arista.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	linux-pci@vger.kernel.org,
	Daniel Stodden <dns@arista.com>
Subject: [PATCH v4 0/1] PCI: switchtec: Fix stdev_release() crash after surprise hot remove
Date: Tue, 21 Nov 2023 20:23:15 -0800
Message-ID: <20231122042316.91208-1-dns@arista.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
 * Restart from upstream f9724598e29df3acfcf5327df11aae2aba1b7f61
 * Add missing pci_dev_put() to stdev_create()'s failure path.
 * Reviewed-by: Dmitry Safonov <dima@arista.com>

Thanks for the patience.
Daniel

Daniel Stodden (1):
  PCI: switchtec: Fix stdev_release() crash after surprise hot remove

 drivers/pci/switch/switchtec.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.41.0


