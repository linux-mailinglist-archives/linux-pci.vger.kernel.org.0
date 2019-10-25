Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD41E5615
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 23:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfJYVmQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 17:42:16 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35611 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfJYVmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 17:42:16 -0400
Received: by mail-wr1-f50.google.com with SMTP id l10so3934614wrb.2
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2019 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GNJc1rR1j79hhkXaFdZUlmiWSIF64yC4QKn+617csog=;
        b=corvTpm1tnK+SOj4ko+AJFC0ohUtwqVkB2GPwKagd6DMv79Y1KfODZIkI2HTbA50dk
         t+emLftvQBsh6jy6TXfbRFNdIR4bsQ///3kezULLZsyxcyIQe3Imj9FM+H+hEO8eAZE1
         TeVNoeOTn7UeI8b+EgJu8L2Za5YvWRBQQV9bc1y1U6Jr9XMvXSvis/dnOJK4hwWCcw+4
         6KNkOe66IKIutXeqKoKfKgXdcye9oiFYAazPshP7YD4qKZYlZFu5YlPaTBEFp7EuK8Nv
         9h/JyUuHPIfP4Zv09cvx/+xGfDiELk87hcUv0fMFz5e8ulavQ+VYH/AOuC+RxVLTctTv
         RLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GNJc1rR1j79hhkXaFdZUlmiWSIF64yC4QKn+617csog=;
        b=dxA62Bu6CJmYKsbmF8U04tgL5OhIa1Y5LNXdS2z2V3WHKplLfnuktYJXPevW0+iP5k
         +rX8cvL5/uaTokKcmIbg3rx0snG+3PHo7Hs+kwDUsXeTN+MqSDgUWa8QzqPolLu1ziF7
         vOpSJLP0QTGgPytJnwCIDO3LC9REkxKnS1AieLuitDzfTUggYx9oLNc3TC8TkZzX0/+m
         t9Bc5IZL/vOxCBKsJ8zFKp0V+7SCU0qyF3L9eIfFPNI6FvwXmYTz8qmCBHIHzQkE0ndB
         /PCdYi6FozlkMND3n+wmz2wkqM2uJSF/BNNU2B86wRsmwcNLqqBo2zatW1J3ZJ49++S6
         FVDQ==
X-Gm-Message-State: APjAAAVJG9CeLEl/VUiWQgoB+OnvxZQwGH8ZSaaxBukoF7JiQR7vqW0v
        FLoPckoLu94ejew/2zg1WalyUtrv
X-Google-Smtp-Source: APXvYqwd9MyN8Nx8BXezJZQuk5OayHXGKeK3LB19oLYBK3SqM61uNbbYc5jCKQD0/TosCF2rxv0t0A==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr5124871wrv.281.1572039734557;
        Fri, 25 Oct 2019 14:42:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f26:6400:adc9:ea2:903e:e65d? (p200300EA8F266400ADC90EA2903EE65D.dip0.t-ipconnect.de. [2003:ea:8f26:6400:adc9:ea2:903e:e65d])
        by smtp.googlemail.com with ESMTPSA id u10sm4395034wmj.0.2019.10.25.14.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 14:42:14 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Drop Kconfig option PCIEASPM?
Message-ID: <1f784101-fe7a-becf-d855-ddc6d03a3f92@gmail.com>
Date:   Fri, 25 Oct 2019 23:42:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I wonder whether anybody actually wants to disable ASPM support.
In an old Kconfig commit message is mentioned that it may help
to reduce kernel size of embedded systems. However I would
think that on embedded systems ASPM is quite useful as it
saves significant power and may result in a lower system
temperature therefore.
W/o ASPM support we have to live with devices coming up
in whatever mode boot loader or firmware configure.

Heiner
