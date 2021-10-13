Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328E742C8D7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJMSkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 14:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSkO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 14:40:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F9CC061570
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 11:38:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t2so11425289wrb.8
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:cc:content-language
         :subject:content-transfer-encoding;
        bh=Q+WFpiSkpxB+Q+fl5Czv/AABMYXD+dcqvmCA/FcDsOw=;
        b=J+gqBJ2+kIrwcfz5iKNAEcR4WhhmecGud2Wbt4+UrPmbOSMmDYCy7GcuZ+DN1AGpxq
         cTwAp8dY9dyeJzmZCqQMOFh7S00KMzcomgwvPhzgu6S3FvR3wGyS6+Rcl/6FRFUgLgHe
         GD0rzxk6WYfAUQkUe2+piLcegtmlwyQa2LRje8M6CisW381lwfDFapIcmUwuF8Qe7rAg
         8KgMgXNxGnqdd4KesQFPzE9vdUxb2xTiqW9GGvLWTXltbJLicdLyAgB8sNSOJh/N8jx2
         cQcsD1VMc7gr3xASH/6LSTVoixoIvDTE+jw/uSAm2dGzF9JjrPH4TKP9R/UrRKCrt9KK
         TsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :cc:content-language:subject:content-transfer-encoding;
        bh=Q+WFpiSkpxB+Q+fl5Czv/AABMYXD+dcqvmCA/FcDsOw=;
        b=bSzQCHSzjdKAoKqC59bZ1TofHQqU6mJ+MiEKEnNJoAEGvkgcBBQWdF5WImYTvhjqmR
         3+hiW+bLA9eVpipxpSArC2ii13XQj/rOHihm+pKkAvGeZJwyG9ZTyJZ2Z6H+C9WNWvWI
         u3PCTPIenTLlzTIc8jGXalL8OuoUC1X0sGU5b4QbS4f4ifx7as/cAmhnNvRCbBfPLPPT
         cc82FtkinHa/0acj3SSF0/8ptMO7vIWgUFoSRyIYW7E3OQ4KklqY2dHU2CkJ8QiJomO3
         /pPunzppXz5S6FpYbuxrkZkufjDKlACCjvHWwK3As1OYi9RD2Iy2qXvuVA80xvvKyr9u
         Ldng==
X-Gm-Message-State: AOAM5314WndB/4NPdh6o1lh0p06pisMH/hRCWZuNXvneTa7+V0x2lCgu
        mXAOLw4DCRROMUJCwRprHN4=
X-Google-Smtp-Source: ABdhPJyus3ou9HYfkXNPtwLkpFad0LGoOy4bFlcNu+BJ9/ll6Eciwx5aLPGwvKhcbjyXaQysgO20Ww==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr869704wrn.283.1634150289273;
        Wed, 13 Oct 2021 11:38:09 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f22:fa00:49bd:5329:15d2:9218? (p200300ea8f22fa0049bd532915d29218.dip0.t-ipconnect.de. [2003:ea:8f22:fa00:49bd:5329:15d2:9218])
        by smtp.googlemail.com with ESMTPSA id z6sm348987wro.25.2021.10.13.11.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 11:38:08 -0700 (PDT)
Message-ID: <223ffa56-7c2c-643a-d3a0-2175e85f6603@gmail.com>
Date:   Wed, 13 Oct 2021 20:37:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Content-Language: en-US
Subject: [PATCH v2] PCI/VPD: Add simple sanity check to pci_vpd_size()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have a problem with a device where each VPD read returns 0x33 [0].
This results in a valid VPD structure (except the tag id) and
therefore pci_vpd_size() scans the full VPD address range.
On an affected system this took ca. 80s.

That's not acceptable, on the other hand we may not want to re-add
the old tag checks. In addition these tag check still wouldn't be able
to avoid the described scenario 100%.
Instead let's add a simple sanity check on the number of found tags.
A VPD image conforming to the PCI spec [1] can have max. 4 tags:
id string, ro section, rw section, end tag.

[0] https://lore.kernel.org/lkml/20210915223218.GA1542966@bjorn-Precision-5520/
[1] PCI 3.0 I.3.1. VPD Large and Small Resource Data Tags

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/vpd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index a4fc4d069..921470611 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -56,6 +56,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 {
 	size_t off = 0, size;
 	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
+	int num_tags = 0;
 
 	while (pci_read_vpd_any(dev, off, 1, header) == 1) {
 		size = 0;
@@ -63,6 +64,10 @@ static size_t pci_vpd_size(struct pci_dev *dev)
 		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
 			goto error;
 
+		/* We can have max 4 tags: STRING_ID, RO, RW, END */
+		if (++num_tags > 4)
+			goto error;
+
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
 			if (pci_read_vpd_any(dev, off + 1, 2, &header[1]) != 2) {
-- 
2.33.0

