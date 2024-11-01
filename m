Return-Path: <linux-pci+bounces-15822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339029B9ADC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 23:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC071282895
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 22:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD371D14EA;
	Fri,  1 Nov 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCfDFB8i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6B156C72;
	Fri,  1 Nov 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730500742; cv=none; b=bnUapHNFKNnyz+QKMQSfMWDSNGHHB67sfjd5HpHnqvhpq4CyO/WYSPBvknC+XnEDPUwKw8rXYihvK+9nTRbz0C5hhVlr6HlojmXNzO8bUq1zIkm7SmrLecqJSjbaQj7toOd/K9lXjrR3hF5yuqp3fx5PZhbmQHRJaRzeFWtt0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730500742; c=relaxed/simple;
	bh=LF83NpTBISvCUQQ2CJXUJ+sDViphiKS6mopJnv2la8U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Agv/Gng+IBEQd+yPu4Acj3VG3hourVTiGWlvC9a/SGqfGIb3UvSQHDLcoGrQlqpOdhG+dT153mO6kbukeQFOXXPq7UzFFfdOfU0g8TYGEd//JkgI3y7QJoTcRvVDjytjczQPWCFduANNbFtyNUaw7gLELbsJJT4pJE997WMOz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCfDFB8i; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so312193a12.1;
        Fri, 01 Nov 2024 15:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730500735; x=1731105535; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nycZu6YGXSNeQTzCTTBCZ0HE7t0bOKmaepNiacR9Vzs=;
        b=OCfDFB8iNaTo6rsb7QxwX++GqUvdzjzgvlzVK+nnAlBpKFW9R7xowqexbt9XTPNlJO
         nQGRHcqanppb27SziCjsSSv/LXJoVrcNLHXjXeHAxpsRoJcqRR/tuPjIHxzg0fFra8NO
         +FNu7d2GzZZq2aRdb+Nzjmsn9OsJJv8w6SlwOwDSA1oAkGx0aTSZ4x+fBQBj0ZyXYIlc
         0VSudJqNabuD+D3jAOVuITZodLTpi0FkQng5kyIRMCny5jGcNrzwmYnDlJ1Ds5FNVi5b
         4jdvHZ1Lgvp/70w4dqEqp+fwGbqAF6kLHeZGRIABcwo0GU3o7srzFtDm17MZA5m7X9r6
         L6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730500735; x=1731105535;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nycZu6YGXSNeQTzCTTBCZ0HE7t0bOKmaepNiacR9Vzs=;
        b=A2RUQDGISTSg2OGeTzDPTdeyH+tnFv0+7voM0CET6FMTyaCRekn+xDfhZOAal7kJq/
         bPoxBOto+JLIDohTKhAGim9sS2q+rYMwbXzcXCJcIj6VEop2/9kgvG0nxana67gvZLQy
         u0MtoAEYBSNzvrvxPqYfUKndrJQa4Dp92e2nx+K3GuVLAoRRdt7jaEizK2ZW9aQE8qQJ
         23Hx5xuRFrXZaBiOfDs6dhQhnKnLTHhLaFJmJB6H3OvAVqYrnoJZ4APVH7NgocqbFdRp
         2HnMZZtOhqfH3jtZ+rZt5HpJpx9qiAWv9HrRB4PFzGZLmpvpfT9UogzpAdB9OgHP38YR
         7LOA==
X-Forwarded-Encrypted: i=1; AJvYcCXqtPeE6m3nL41Fh+/njdia9+j/IBXN7ww2R6T926YXZr8gv7D7kezpby/HqXD2dhW8U0d6Ak1Gn7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlxcjHKQ/TWKPv7JAwIZPSm4Bweaw9skOOfOHCXn232ydtBLU5
	7VuMcvsWoErgkthegXuWrNuDcn1k20jszS5lpdy+TuSgCQ5YOwxQ
X-Google-Smtp-Source: AGHT+IGep/zpIFBbnVybUTwHuIayPWxRFWxgvdULCxCYyrRy1CgntyhWbZzM/Mc4QvvQka8efeVPJw==
X-Received: by 2002:a05:6402:42c4:b0:5ca:14fa:dc87 with SMTP id 4fb4d7f45d1cf-5cbbf8ca0d4mr20387979a12.15.1730500735173;
        Fri, 01 Nov 2024 15:38:55 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9dbc:bd00:c5db:e5ed:512d:1904? (dynamic-2a02-3100-9dbc-bd00-c5db-e5ed-512d-1904.310.pool.telefonica.de. [2a02:3100:9dbc:bd00:c5db:e5ed:512d:1904])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7c8ba8sm1932408a12.69.2024.11.01.15.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 15:38:53 -0700 (PDT)
Message-ID: <c604a8ac-8025-4078-ab90-834d95872e31@gmail.com>
Date: Fri, 1 Nov 2024 23:38:53 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Philipp Stanner <pstanner@redhat.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] ata: ahci: Don't call pci_intx() directly
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

pci_intx() should be called by PCI core and some virtualization code
only. In PCI device drivers use the appropriate pci_alloc_irq_vectors()
call.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2d3d3d67b..09090294c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1985,7 +1985,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (ahci_init_msi(pdev, n_ports, hpriv) < 0) {
 		/* legacy intx interrupts */
-		pci_intx(pdev, 1);
+		pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
 	}
 	hpriv->irq = pci_irq_vector(pdev, 0);
 
-- 
2.47.0


