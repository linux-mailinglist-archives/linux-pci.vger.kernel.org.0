Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3C5231273
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbgG1TUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbgG1TUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 15:20:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A535C061794
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 12:20:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dk23so9911365ejb.11
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DmxU1ZQHeM+W9godv/svS5pNW8bD5o2Izj6jcWA5jpI=;
        b=QRMnQHC96h4kJz8z6AQO/D9yEs9RK2pmR5clsbFgmniit6RXSbM+V8uA8hgAh+l6fZ
         tPbsMA2y27+8r4pF6206ZJbU9/PlNA0HSvII033MXty6wO6XtAduFvutuQMVpbhCmvXN
         hdgHY49ROnwcABfor/WnXc8NaOkjlGEbW/dzoXhBvjm15WxpJYJ0+GSm9HjUM9DJUcCi
         gqJgjt2U9dWiWNL46C04kfXsW+0pgEUlsblJx2hHPor20lPatC5In5sKLwnfhB8OLbRd
         JTfC2ocw7mN8NN58tGAO5Oh5MichETG6vk50pXR1IdPatVpDA4fL/5LSgeaTXdsXKh5i
         O6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DmxU1ZQHeM+W9godv/svS5pNW8bD5o2Izj6jcWA5jpI=;
        b=BJWQtlaqa8SlqwFAg3uGQGmkYbqlk0zbREi1l1Ph6VpS7WwnAlXl2COAtHWy0QIcRG
         E0u5abFAwiPStphzt4J/t839ajb0pvDyXH56NcXC0ue1Fl0OK9dLffECW27gTL1Q5ayZ
         XIi+Fb316aweuHzD+0zuQaGaZBYD3fcgADGdR4Z4L//zGvwxP7q36MB7ZHp6mudt1KBm
         lPuyNVIMY65u9VDP4/FNWbUbXzJk74DCShV8nWu9arxggm++QfOOOmIAuLzlhitJWS+M
         XB3mpleEDJ7HFuIu836yfPH4ciyhuQTKS/yd1MJCj3Qp6qt+lc7pDnbkHi3+nCkPURDc
         J51A==
X-Gm-Message-State: AOAM531oBW4TyT1T5kdd28bMMafwOFzvjX5NKlaC9113r8Jr++wj5a7o
        0qvK76lIXSkEHO822cia+ecElOP7e1Y=
X-Google-Smtp-Source: ABdhPJwkTER2qdWVtegQ1SmnEnGrp/gzd1SFj43vPRL9zQb7QFW4cu3KpXUVvXtspV5dLadXnyATcg==
X-Received: by 2002:a17:906:2816:: with SMTP id r22mr3136715ejc.215.1595964041807;
        Tue, 28 Jul 2020 12:20:41 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:908b:a51b:1175:f3b2? (p200300ea8f235700908ba51b1175f3b2.dip0.t-ipconnect.de. [2003:ea:8f23:5700:908b:a51b:1175:f3b2])
        by smtp.googlemail.com with ESMTPSA id e10sm9123269edu.51.2020.07.28.12.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 12:20:41 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: pci_lost_interrupt still needed?
Message-ID: <f5eba931-6e27-8f50-d018-7d51a983bfb8@gmail.com>
Date:   Tue, 28 Jul 2020 21:20:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seems that pci_lost_interrupt() has no user. Do we still need this function?
Same applies for related enum pci_lost_interrupt_reason.
