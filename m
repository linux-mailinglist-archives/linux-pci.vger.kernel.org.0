Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86004A5623
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 06:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiBAFUL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 00:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbiBAFUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 00:20:10 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB13C061714
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 21:20:10 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so15166350otq.5
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 21:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dU4yltLY5HmP1n3h2pouklPO+HBAz73LqWvT+JIOPdI=;
        b=aBRWuMtkS1rSpTahXFtDOq370dbAXY9KuQ7NZNQX10fcCTgp02o4K8A8z6RTGVkqga
         Ffkp9q2rd/kmqdijO7dY7cx93neOzCSyeUnKljJe7jn9gaFeHqxWTX3r+hXoO2GtuNFt
         xYPkJKUwCZniq8RFLPXXyrD2DmIbK9lFPnfo6XG7Wubj/W1fxofiJvRlJTm/SfR7f6rk
         V191rmsRNk+aKjLz89pbNEU1JlzA0mANZKj3tusk/xkqbdPi9smP/m5I5RNcCBMt111x
         dMxkEuc6BPBHClLHu1XlDkilnOz9duUAzR7eLc7NcyDcRHumii6jT79iSCZoX1AxsYuG
         zueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dU4yltLY5HmP1n3h2pouklPO+HBAz73LqWvT+JIOPdI=;
        b=BUvdeHeas+7eUdo1Z/xG9Rg5eWpJ02URwu2/oy+l/ee7wJuIgOptOZM8m4rb/aYl6e
         IqrSRQ3MSIk+I6nZX598L904prybSxtl9Xno73067idr4yhVSY0o94X4N3V87L2yv12S
         aXQMIcU9SbIWJTbqpYi8ZsvgJ7sfgxDJwXCyuj//rBnrHplHMn8pmoOR+5PB17OsR2zv
         cCWi63nAUuG6ellTXYWXrNMFdDM4x2Jux6k4X4LjvMjnMq6jOwpLkR34aHg9N1JAReoy
         X8mAI54pt8rBW23DDdJUSjN4o0yukBYuanAIyR3kX8cMy9zs3UzsMkIeBeZIbu8H4SwC
         NVjg==
X-Gm-Message-State: AOAM532XMXFQQgfV8teNu3Qfb21UWxEbdA8llpXicd5xhNCjLkE1TAYu
        v5B75R5dO4bnUBNmMmW0WoEYgg==
X-Google-Smtp-Source: ABdhPJzdc4ugViOuYmVj945+gw2qmW1mh3M/ZmlT1F+pxp2V8y+UKJDTS4ntw6bTdg76IBLXbDHA5Q==
X-Received: by 2002:a05:6830:402b:: with SMTP id i11mr13649950ots.195.1643692809768;
        Mon, 31 Jan 2022 21:20:09 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:09 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: (subset) [PATCH] arm64: dts: qcom: ipq6018: fix usb reference period
Date:   Mon, 31 Jan 2022 23:19:19 -0600
Message-Id: <164369277345.3095904.12034433067410080993.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <4f4df55cf44cd0fd7d773aca171d4f48662fb1a5.1642704221.git.baruch@tkos.co.il>
References: <4f4df55cf44cd0fd7d773aca171d4f48662fb1a5.1642704221.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 20 Jan 2022 20:43:41 +0200, Baruch Siach wrote:
> Reference clock period for rate of 24MHz is 41ns (0x29).
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: ipq6018: fix usb reference period
      commit: d1c10ab1494f09eb12fa6e58fc78bb28d44922ae

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
