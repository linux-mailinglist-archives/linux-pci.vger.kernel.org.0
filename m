Return-Path: <linux-pci+bounces-38036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC8FBD90C3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C5734E850D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB82C30C361;
	Tue, 14 Oct 2025 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLDNKlCe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD12FE055
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441564; cv=none; b=MeBlFta356zRjJm5w3aVEm+rMQzVVv2ubXs4VIat/Tk1M6ieHeM3Owo7R/EdjDRnQY8fH/x02i06++ofj7H4SR/FVdYtizcZ1YWHIuemHc8ngQDU0P5RukxljJImCYlGHppMgUtBO6wc9eyu4DSFJSR8EFbUdTjSgaZHoZ+1Wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441564; c=relaxed/simple;
	bh=ger5yta4kuizbC1oqevE5vf2viR2j52bwfv7+Byb+Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrFMNcuCA8OS53E2sITFxzSS+U8idMuwZPCIsOdY5uuFC0bTN7mi0sLaZM6qF/A9rqT/qxRmUFIiB7dtjM7LzvEgMYeMwLRGIYaYrU0qOz5uZZDTn/rFEVDgdZyMB5vEQa8eiWC5EoM6zrdqC9uLEsHer7Kp8R0+Y3PKpGTnVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLDNKlCe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3304a57d842so4189719a91.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441562; x=1761046362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0C3j15Yugc04L5diekbYBCyapTdq2v/4isDBpQOj5g=;
        b=aLDNKlCeNGAS0D91pz8FuQxsI3DaNq2eRK9akzUk7JQWO646OcyogTCG2wUhrItO6Z
         0vnuupyLJlb3z3aFRbLtdCtxOqbxBybcF8SOUv73dUJFhhIy59KyiggAxL0p9+Cy6G8w
         TjiDu2JJc0ZFdyGgw6lrSN2tJtPQ3FPEVWYT3A7/sneUdxP12fw8bFBRcp5ZnMeeg0nw
         KS1jnkAPznWsHfeftoy1yPvmlT1y1mQxXxx5GZgu5Fr1cawVaaTC6W5V/Au9IoEscjAn
         kBasgYL0VJo45avGcN4V5hlM6wrhFtXKTVWHC5F/57TI009C6cjjo1Z8dZO2DjSHV+e1
         QLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441562; x=1761046362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0C3j15Yugc04L5diekbYBCyapTdq2v/4isDBpQOj5g=;
        b=XNUA1RmO3t6yd8XxcHDXRVw7i5RcmNX0qZA1dytiCEFkGxBZDhjORFvuo3CbXzGeMS
         ED4ts6tWf2EzCyvTXZ5DU75OV7jQ5l1rzPjU+wBhlx4rVB44N7d0I+H+iKjypMywpIVK
         taYhty+povGX4KRoJ7P1Jj9TowRLATtDgwuoQv6iV+wPTAU0ACLF1ClYS9ZU0qS0vWu4
         kUe3iMJWu+QeRqPTfltk5TI8BRz+qWdd10NI9I2lf5x1BR3OyHYc8qWRlAyEY+Msm2Wj
         NUXUzGgoBE8tNKhd8alhYcJYh2uTuVhSxgpS2WfJ3TPuoIrWUQoy8iPtBZbbmtspFHtO
         jtJg==
X-Forwarded-Encrypted: i=1; AJvYcCWkwzHqoXDwVJZvaGIDpOUEUe1pXrAwHwroWcySv0/Prjl2Gtp7bFly1HJL1jvu5qbSA1noj7IdOY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsCGzKr4oZBQX7cGTO2WbJfaD0WxkziVMNnqiuRECvmVJ9/Uh
	Dvp45zMzW3buOilU+nKT4Z3Hb6QVEgRZPGZTk//gZ4GruqY300e6JL+Q
X-Gm-Gg: ASbGncuJUXeWfTEsTBeRVRkSOnGrWXVl5xXn4DPJ2BoxwLgNcA0rPQ2mqN7QJgTGvCz
	vIK2e3s1/ut1dtKFbNpmKvSWgV5Fc99jWEki/+cnYjeK4OPStrmYKgrR2AOeGdxNLORMSDOg7KY
	QfLEactZVYgAuLnijwdxdKE8tpPSETxzTOZWG6vXrqFhNCQR+3KMzDLXnsAB34m8d48EY0umOCR
	oKNZdkw4pf0f8amueqwZZAeSeKqOQitSohMitoopQBuABR7NAbPQkK3HhUyhSU6/azprietG68z
	4sOEJI89+A8e6jN6abyP9tWl3DJWEr/oYO6Es4BITw2PqSTqdyDYThHPynpIgMZa0//SiPGhA1A
	ikZzgU+f59qDHd7JFkKLCWSQ9wYuyjwiv3cor7uE=
X-Google-Smtp-Source: AGHT+IFOXw7annfzhh83UINHXYFo00qKcPjKDkiEC3wElyWcHBIp7o3ZfuqFZw3zUefrPIrk44z91w==
X-Received: by 2002:a17:90b:1652:b0:32d:d4fa:4c3 with SMTP id 98e67ed59e1d1-33b513cd9damr31858712a91.31.1760441562336;
        Tue, 14 Oct 2025 04:32:42 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0965c3sm14871383b3a.52.2025.10.14.04.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:32:41 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1 0/3] PCI: j721e: A couple of cleanups
Date: Tue, 14 Oct 2025 17:02:26 +0530
Message-ID: <20251014113234.44418-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the J721e probe function to use devres helpers for resource
management. This replaces manual clock handling with
devm_clk_get_optional_enabled() and assigns the reset GPIO directly
to the struct members, eliminating unnecessary local variables.

These patches have been compile-tested only, as I do not have access
to the hardware for runtime verification.

Changes
   Add new patch for dev_err_probe return.
   dropped unsesary clk_disable_unprepare as its handle by
   devm_clk_get_optional_enabled.
    
RFC v1: https://lore.kernel.org/all/20251013101727.129260-1-linux.amoon@gmail.com/

Thanks
-Anand

Anand Moon (3):
  PCI: j721e: Propagate dev_err_probe return value
  PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
  PCI: j721e: Use inline reset GPIO assignment and drop local variable

 drivers/pci/controller/cadence/pci-j721e.c | 39 ++++++++--------------
 1 file changed, 14 insertions(+), 25 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.50.1


