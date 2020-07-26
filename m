Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E735422E2FC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGZWG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jul 2020 18:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZWG7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jul 2020 18:06:59 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143FDC0619D2
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2020 15:06:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 185so4930272ljj.7
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2020 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCdjVYFDE/BuztCYz/aN7m8ExQ6pdvDrd3SImMCzZ40=;
        b=f++DId9QRsZYnMbWi3vfueFmUwhmcnPDyW81zWKbhbSYvzuahuuaAImDzyTiLgbykf
         QCZwke8Zt8yulKPTHZQkouTIIIsJ0sTYvtE6XWP59XNO5q4lCF2vZwpp3pZWhg6LLmvk
         u+3zXLPyKnWRhjGYWOxuAMITNOLtUmCN7Jv06Xul8BgsYj2/NrdfcDsC/eTFzPgDfvZN
         BGWSYKoehLEEhPEXJB/vaQuu01uSl1iAHLIPOTYsRPjyLO9T5ZwFRDXTkTCXcpAdMz52
         hVuqYQwR8xXU+j3tt++XMwI+NYciBCuQU3RSQOw02ixdyiGRTUCzRYTM0VHSAOAu2NXj
         OgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pCdjVYFDE/BuztCYz/aN7m8ExQ6pdvDrd3SImMCzZ40=;
        b=sAOdPYUXuvPoOBKLawscr0SL4pQrXeK6ucIUwLYR/P6+A4sosBeawTd+twv6S6GD0s
         /+5iVCh5CS0G0MFtmKzU9yIwZER0i87ojwddu7pIRUjLt8Be0MDXtzWqupZ6BCW9Yo88
         rGl3DYLhd78O7VjKlHQzXFv27mCXnu7mv6G5INpmrwkAbgtPggptsODeJvwTzJlhVWwF
         cUFhs/z0biWX4H+ejJaQcHFOCd/qn8Ik9m0X03cNAwH1WNp94OrnbPrfMepQ3RfvdE2Z
         oO37EsyGLV3QEivLoJiB4yTvioWtY21BaAjPbtyBcZ29SnKC+xdacam0e9kV3vmL/QIM
         zzlg==
X-Gm-Message-State: AOAM531+jLDKHJIveiemAwuPBwuOKA2foX0lj8LSJ+H/iCv9g0JhlPe7
        xOngdh8GVuDEmdRhOCwLkzGH10skMvY=
X-Google-Smtp-Source: ABdhPJzIKXck9oadvzZEQJztwKbJQCGO6OipMAiCrl7bmZLih/UqvXeiaerAJUEFVrE6+Osn5nVL1g==
X-Received: by 2002:a2e:9d90:: with SMTP id c16mr4489581ljj.20.1595801217052;
        Sun, 26 Jul 2020 15:06:57 -0700 (PDT)
Received: from octa.pomac.com (c-f0d2225c.013-195-6c756e10.bbcust.telenor.se. [92.34.210.240])
        by smtp.gmail.com with ESMTPSA id y136sm2590835lfa.79.2020.07.26.15.06.55
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 15:06:56 -0700 (PDT)
From:   Ian Kumlien <ian.kumlien@gmail.com>
To:     linux-pci@vger.kernel.org
Subject: [PATCH] Use maximum latency when determining L1 ASPM
Date:   Mon, 27 Jul 2020 00:06:52 +0200
Message-Id: <20200726220653.635852-1-ian.kumlien@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, just thought that I should send this out properly... 

I would also suggest that this should go in to stable, if you don't
disagree =)

I'm still interested in the L0S but I don't know how they work... 


