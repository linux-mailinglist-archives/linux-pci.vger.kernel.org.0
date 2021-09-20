Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D73141110B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhITIgC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 04:36:02 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51714
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235913AbhITIgA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 04:36:00 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6B09F40293
        for <linux-pci@vger.kernel.org>; Mon, 20 Sep 2021 08:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632126873;
        bh=GlnCPL/n2TbFZ5lKXBBdaGTEcyYQg+Xe+TKmdfu9J3o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=KzVsOYcYyaUwr1qtgGbakLStLWseTMeWPywZ58v5Z83dPl4wdnSqLDknc3iUvfOxi
         Z9CUFLvfmcB9US4rssXk5V6KA95I0oavaq/zDmP9qHqia8ENUB7zPvDkIPA55ruHKs
         1rnuTnSXxxF3/7IU5o/4R+sDQiXRPydF/lGBnxPmHtjOm7uPqBZPRKktNbAWVE0MDt
         6XJGbZvuqKZ2kfVXwiPa4N522igwo4Z/U13pHyg5trDdtpbf55gRMh0mrsDNdQq5UB
         2wSY1doBnGleB7MaXXcIllewff+SXosI5Wao6cxTsZT4yV2kju6NvIXwiRFD7+RjA2
         EgcRfL+wCAyTw==
Received: by mail-wm1-f69.google.com with SMTP id y23-20020a05600c365700b003015b277f98so4484133wmq.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Sep 2021 01:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlnCPL/n2TbFZ5lKXBBdaGTEcyYQg+Xe+TKmdfu9J3o=;
        b=k+JzeSAxxC5iRfsipzUmwXkiaef5aN7xGoWHr8FpW7iJ7+t/hj8XMERSl5SHV8FriD
         NDb+jvF/tHqVcGRX03R2d0klmmFCk/Ege3PS8kjI0VLK6+ZKjCduEz7XuoEiUYeaCHB7
         SypN40/kmMorUMka/4qSAHqYIl3d+iSGsmxH13RXtexltGbDVa3HLUieheFxcwcgRA6G
         9Z0/QuQfyu/Agtk3Fu/Y34CNwM3CdoFhH3RRkzEKlZDwHXBwbZPXCdXuE6BGbzEKG1Lo
         Ks/JImRfDEN+vRUcpL2KugpbvL0dX0RbLsDwK51yDPGc26GKIs21WQIcnbRx722GhtHz
         UcEA==
X-Gm-Message-State: AOAM533jbX24o6qA0JY+AcPBtAIkt9nLBwy0JaXm1stkuMLOZnSIXmNN
        qLCuuwLeGW0KuBNCNxXi7+Ow81GK6iwmrDVKFAgHN/ybP7iRiBhorqMaxsE/Gz0OZDviwLbV2V3
        PcnCnG6SEsyz5lzd8aB8xkgKds2auEghJok4pXA==
X-Received: by 2002:a1c:2056:: with SMTP id g83mr27578664wmg.27.1632126872640;
        Mon, 20 Sep 2021 01:34:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ9ERCT7KUv6zwsHvcBjFyA/Y/awEBukLBanBzL4Ra5L9b9at0dRM9wxlTaF4DW/RU0R/XQw==
X-Received: by 2002:a1c:2056:: with SMTP id g83mr27578645wmg.27.1632126872454;
        Mon, 20 Sep 2021 01:34:32 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id v188sm4658891wme.38.2021.09.20.01.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 01:34:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     p.zabel@pengutronix.de, viresh.kumar@linaro.org, robh@kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>, amitk@kernel.org,
        kw@linux.com, rafael@kernel.org, thierry.reding@gmail.com,
        lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, jonathanh@nvidia.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 3/5] memory: tegra186-emc: Handle errors in BPMP response
Date:   Mon, 20 Sep 2021 10:34:27 +0200
Message-Id: <163212685894.112070.7948621267940223581.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915085517.1669675-3-mperttunen@nvidia.com>
References: <20210915085517.1669675-1-mperttunen@nvidia.com> <20210915085517.1669675-3-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Sep 2021 11:55:15 +0300, Mikko Perttunen wrote:
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
> 
> 

Applied, thanks!

[3/5] memory: tegra186-emc: Handle errors in BPMP response
      commit: 13324edbe9269e6fbca4d0f5146b18ef8478c958

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
