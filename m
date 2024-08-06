Return-Path: <linux-pci+bounces-11344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3F94867F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 02:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29127B21072
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3DC625;
	Tue,  6 Aug 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gyi6PiAf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19D12C80
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902829; cv=none; b=IH4J5ZCY8BQ+F/uyS+hnt2oE2G1Gi9zFuzVCGZGg3kMivQHahq2ATs9X31fQUCIYmBlx4yQ97ec5mwj3j1Fa9Ap3sKlBlnJTk1g+luHtsxj0UAOeo3U8tJNELNv1IlF3aJB1xuLoglfi4ksCaX7lotQlKN/G6TZTqkYXgohGcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902829; c=relaxed/simple;
	bh=NAHTjQgD4+zmcG5S0XfaQDNArJDKgMYBVIZNZ/aJ1Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gzN6P7rQlMlyVD/bLZERN//Hq/PseflYe1p68rq36jz3E8/4bLGN+mkObFmEeNqXImJFp+hZXsUES3Z3e43GVZjYIp8Uebw4o+SjCcx+uNOiPmOZOF7ceZhALdQUvLla7K/wtF5Q3OExbaLupMjniOzSnlGLUAMOOnjnhVj8ESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gyi6PiAf; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so10366a91.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2024 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1722902827; x=1723507627; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAHTjQgD4+zmcG5S0XfaQDNArJDKgMYBVIZNZ/aJ1Cc=;
        b=gyi6PiAfpTtg5/so2yw0etJtg2QCDRm8C0zEyRpp9tdYYZlbvY45jCuW3P89Zpwopt
         +cnFDTINueWp+L/5E3/qv2aFbrYs17cCr4CqBiQ3e7cvEEIb3Wz5gTxXalBbSiCDpR/w
         xVl5q/ddOKEqwazgi/HGgdIludwMX34FoTOT1w56qRoF5wtZGPymdkRbiX0RxgTN25vZ
         B6fQ76RwoD/Qtilp3hdUl2NatvZGRZN1X+g9nr9UQBLuZHFniEp38VK4KEg5STQDVu5x
         T/6oFOUd3eNN5S09pxYbCFAQMKkwswndM1f2nQzFbdWd8WbKadK5jjnxIBMk69Z4YwZQ
         t/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902827; x=1723507627;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAHTjQgD4+zmcG5S0XfaQDNArJDKgMYBVIZNZ/aJ1Cc=;
        b=SHB3gfZQfIRqs0xrhV0YELUqmKMwSWxSX61DuXBxpUAB3w0HYc9AlCm880RSFiiPnP
         BEF8AD+X8MUwa3nzbNA12bTTIV5QL9a4WF3VZzs7EonjREykRhiuje9BxlJ+NrqR1QJb
         Vx6UJJa/iw+GegpxV+L9Xr7s1HJhkTKYIiB57KarfkNB5EqB4Ir63RkhpIBRMU6S79eb
         rH6ET+9OFnSC8s64jUkSQ76MZqvaNvbQXVTTVws9QFDO5PIrRrpzq8q2ESvSOCMifsNF
         LaF/fy63HgsyZSPgUfAT7Ec2rwIqrQvzdccjGH92IG34WCBO5YMda9L2j9A94Yzy36eN
         yeuA==
X-Forwarded-Encrypted: i=1; AJvYcCVlRyv0slJPjTa2buBPKAfvWSo+c+zuAaVRP0vmDekGjSFyPlT57XXU7eGqVhbMfk0ntjNxVUo0LvYcfIL2GJHYKZsOEz6wGoOd
X-Gm-Message-State: AOJu0YxafVpuS0ArOJa2d2tcpgqT1KGanBkrCke/8X88tHq2CVYueCVU
	gA/G4Jrtw60NzZQh6CiGGpOJQL6rnDWcLdNN7skO9UEq1RFC5VbwLEDaO1XmnNI=
X-Google-Smtp-Source: AGHT+IEQSHScRjfnGvU+Fw05tXfpsc+P5lXsv6/4ahugCBzY43bWRk3MpQCenDGZj1yYOONAG+y5yA==
X-Received: by 2002:a17:90b:1e04:b0:2c9:8b33:318f with SMTP id 98e67ed59e1d1-2cff94143damr11644050a91.11.1722902826882;
        Mon, 05 Aug 2024 17:07:06 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cffb388ecesm7730694a91.49.2024.08.05.17.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 17:07:06 -0700 (PDT)
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
Date: Mon,  5 Aug 2024 18:06:59 -0600
Message-Id: <20240806000659.30859-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2306201040200.14084@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2306201040200.14084@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Hello again. I just realized that my first response to this thread two weeks
ago was not actually starting from the end of the discussion. I hope I found
it now... Must say sorry for this I am still figuring out how to follow these
threads.
I need to ask if we can either revert this patch or only modify the quirk to
only run on the device in mention (ASMedia ASM2824). We have now identified
it as causing devices to get stuck at Gen1 in multiple generations of our
hardware & across product lines on ports were hot-plug is common. To be a
little more specific it includes Intel root ports and Broadcomm PCIe switch
ports and also Microchip PCIe switch ports.
The most common place where we see our systems getting stuck at Gen1 is with
device power cycling. If a device is powered on and then off quickly then the
link will of course fail to train & the consequence here is that the port is
forced to Gen1 forever. Does anybody know why the patch will only remove the
forced Gen1 speed from the ASMedia device?

- Matt

