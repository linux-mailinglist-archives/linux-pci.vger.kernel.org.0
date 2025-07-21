Return-Path: <linux-pci+bounces-32655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB26B0C722
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2524E01DB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E68519DF5F;
	Mon, 21 Jul 2025 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtUiAtrt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCF13C81B;
	Mon, 21 Jul 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110032; cv=none; b=IBrLxGc0jqDqKl7NzzlgI6ZFO+CRG86+8qSapho27otyf3MQ57d7A6UjMkJv4tz7X+yE3al1EBISDTSbVhHSh+bTE27AUdvcMIj+N/3JT+vF2kRoy/EwnDDJ8wqLmvc9Ott9Rpdy62mntdN0INWURtsRSkKi7bTnL0S0ah8XfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110032; c=relaxed/simple;
	bh=1u26kY1ws9cxhBGjecBiZxykAFQE/6GBsWlroHxvc6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+ZC3BA1AYuSxLRudxhunMkArXYn9ZriWRJ1v3bpFHHm225C/IijcBlzVSuqhh1HkoMCkGiPsWhkNlc33On0m2u6onUxj7wppI6j2CkLxrB5tmZg54K6edFIOBwEZNL0XQKpem9zldTSE15M0lyrU3NJ61K4kF8Hom/rCHoq20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtUiAtrt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so1994522f8f.3;
        Mon, 21 Jul 2025 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753110029; x=1753714829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2PB0irW/PF5RfhguedJlSTXVHWilPTDJ158mA6czsCc=;
        b=gtUiAtrteKyVTlB8t2xu64W+BzIrBelFx/mwl+jfI/duxwz6WFJI3cjUgGKCHauc31
         1ZyjZZBhW5PW0rcOOBnHXx+2Rbx+oR1puUuT1LoDmvnr5hLKqj35QTVe2pUTvOvSB5sP
         cIxsnjjMznSJ3VAGvZHA6U9hiXZn11GwvpO0hilSP7wWzi39M+s80HRhlMpA/NfDygOW
         NKDyp/4EzIk8nPWkHD+vFIMJ71va/jTT4t+RwfH8ywEYq+d1wC6P5ksB0n9lKVoFdAOm
         6mKQaCvIiRH1d7D/Ac8/u886SMM1LxIEGicKR6Y8CHDi8EJbqZrLxoSbq/p/31+QfiYA
         X6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753110029; x=1753714829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PB0irW/PF5RfhguedJlSTXVHWilPTDJ158mA6czsCc=;
        b=lhBt+vf3iYFbu8EdNYEhCqnUdizqPDla/jPDJLiQZGx6kkEv9NUP4gYXedsdqFfEb/
         PymULiOKmeCUbHXgm5Tn2VBx4rJunAxnEluBBUGOkCW6d1MkJ8F2OnDiJBM/uxRZB2so
         gmMXNnj82iQ5reP835F/QSkKe41tFRYB/FSzLMIUBzRby0Pxv25r6tYNxjdYOzJZHEu7
         q9Uph+v3Yx2ObhVmKWwFRBfrPfTlogjierFwgsFqnMpup6vLkmyikhU7Ix/jOeaNoTwl
         +LfrVGT9YzM+I3LWLUbrHRcQIs6w1zD790pyUgGLxYgDbCWJiZjK2anBtUT8AB2H+Y/4
         RtSw==
X-Forwarded-Encrypted: i=1; AJvYcCVFVlnsdX+r/52pZrFvn9x0eI7UUZpw4nDH6BibU73ojk2VYkN+ESiEVmd/ZJis1TczF2I531f+UY49@vger.kernel.org, AJvYcCVTWqcdcJVUimvBSK1OjATmlmBbGafDwcGloShudmdAA7KG0J0w1uRgXS5Dy8DE7MCaXmRj9wJGGB4KiHOD@vger.kernel.org, AJvYcCWkmfmM141bnfFrUFPzpTUbHCsr1agx+oKz/jxJd2VmfvC+qjH/KtWdxZfQyFFhKESXY4XRL+R1l4cB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OkRVKJRgcyZbysDMAHtn4lKYZEWK7e1G1pDk3PxaUoVxlreK
	XZtXYD29IbjU0NdzuaKk9u+iOz2Dx5g49ZaBnay/tK0Mimm831jOJ8ER2EpK1m/BnDQ=
X-Gm-Gg: ASbGncs+FE2LmTYTS3sWoSp8yghMDEwowLpZF1jIxpIs+4M5vWBz5Ul7h20zcNsjBbn
	7U4SgAiuNStKZP1zAq7iDtrfs9fjCXe33CiqMzdG3RE/ZdFxu2m2ajNeobiCHEhy4wxyAZJMZVx
	sSMliwRcOFUywVjZPUdPBT8EtEsx/FFGcIIXcZFDzeijvhE5OSk4UoRDara+MgJn4iri3u+7Vgr
	n2BAaaMHcGskVnRPiHf14iyZVEXgix5kLTN6znoUBgE3A/qBjUlpC9CuPG9yaVGW5YtwOlH5rIP
	+U7YGhlsuz/PT2SqNw/Q7FOm95iLEkCnkgsrMmAqn9U7K3poMFlYQBsD4hloPhMfKWirUeLcFS2
	eUGMoXUrk2wlz+BT5dsTM
X-Google-Smtp-Source: AGHT+IEnm5Z2sHlscy3eq1RJ/Z17vAMa+liMVtNJyEdVCWAmNxBB9ZDteQYhEZsZXd+wtJZbuTe+Hw==
X-Received: by 2002:a05:6000:40ca:b0:3a8:6262:e78 with SMTP id ffacd0b85a97d-3b60e513909mr14535725f8f.37.1753110028526;
        Mon, 21 Jul 2025 08:00:28 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca25410sm10808671f8f.1.2025.07.21.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:00:24 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ACPI: pci_link: Remove space before \n newline
Date: Mon, 21 Jul 2025 15:59:52 +0100
Message-ID: <20250721145952.2601422-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in an acpi_handle_debug
message.  Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 08e10b6226dc..e4560b33b8ad 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -268,7 +268,7 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
 
 	link->irq.active = irq;
 
-	acpi_handle_debug(handle, "Link at IRQ %d \n", link->irq.active);
+	acpi_handle_debug(handle, "Link at IRQ %d\n", link->irq.active);
 
       end:
 	return result;
-- 
2.50.0


