Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7C7723EA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjHGM2k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjHGM2j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 08:28:39 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E3BE79
        for <linux-pci@vger.kernel.org>; Mon,  7 Aug 2023 05:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691411313; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mz67CA82g+G63urmX7GFSxCdMnvMChB6/RMLLbq2zqUCinSWrvwyhCG2Z3Cj4w9YfkmCGQNq2tzDpy8cvhiZOa2p8VRIanR//lDk4e4qVHBVFAYu1BqQ+i7YwVAIXV5Hsqvzr5Pq3+mBA8nPCWKisCNRM/qIiVKuj1gjlkcaJS0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1691411313; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=Z8yaywXn3VNx20bmr2DiwZwww8H5Ln8FLZ2E9cMQ6xE=; 
        b=KtCOgYJiawBopcUYNTQMF5a0YZEXWpUdGTV1hdzBHwoq0LaKO5sKbZ1MYzKWwqJ3R72NBppRR7Y4cxCIxyjRUJVfuKyrBLwKlZOzu+a7GVggLvrM+WhO2cQGPuIqwwJQwlhGUSEz4WNdltueYeEduRIZfLNs/k52EI+stuPABkc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1691411313;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=Z8yaywXn3VNx20bmr2DiwZwww8H5Ln8FLZ2E9cMQ6xE=;
        b=GwJ6qPck2PWJm4Of5xc6q/rQfldUHPsQXYD4LNAZTleZxy+vqJUK48Kl/Yt+hjuM
        nk8AylnxUKWt3KBlCZrpVBj8V8BPNJ+PpOLbcWAnSZPCuMY42oMz5dR/vZVoWj4a51g
        35eXJ65Bivd38TbuXjWz/8hx5UprsQA/4FUxc6cI=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1691411310192614.4232931201528; Mon, 7 Aug 2023 05:28:30 -0700 (PDT)
Date:   Mon, 07 Aug 2023 20:28:30 +0800
From:   Li Chen <me@linux.beauty>
To:     "linux-pci" <linux-pci@vger.kernel.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "mani" <mani@kernel.org>, "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>
Message-ID: <189cff865f3.fc7e71c96186.1411633612292556520@linux.beauty>
In-Reply-To: 
Subject: [RFC] add __iomem cookie for EPF BAR
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All

Currently, the EPF's bar is allocated by pci_epf_alloc_space, which internally uses dma_alloc_coherent and the caching behavior of dma_alloc_coherent may vary depending on platforms.

The bar space is exported to RC, which means that RC may modify it without EP being aware of it, so EP still read from the cache and get stalled data. To address this issue, the bar space should be treated as iomem instead and forced to use io read/write APIs, which enforces volatile. 

If you agree, I would create patches for existing EPF and EPF/EPC core and submit them for review.

Regards,
Li
