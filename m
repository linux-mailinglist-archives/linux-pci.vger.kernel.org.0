Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9414D700D2A
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjELQkL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjELQkK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 12:40:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC6900E;
        Fri, 12 May 2023 09:40:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso73356915e9.0;
        Fri, 12 May 2023 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683909606; x=1686501606;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOPr8RiZNSgqggpmzVuoRlbviV7C/s+3BUUqAAb6inU=;
        b=DOCSZD3R4gA0NV+uJmIYMvCPKGm8d9kpASOgAAz+Pf4S+bC0zfZIpDVA6j4pA5/G9z
         2pv/aZk9u0O0KFrGIRGMFN5sxS4S/44ucOrDp+w9VpWR4uuZvwDTzUhBQBhBZ8S1Tz3B
         A5RVjIX26Ua+r+QGuGgXEYRPOaEK2M0bQL6s3XxHIXuZRKLWM+xfN3SpYRT0P92uopQt
         CkJRyCOBuJ4vl5d6ZVUxN/FPuTayqcbUDbcbnkY8KA6iyaI8vGfTnKQJuxTpkgX780tb
         2n2REXdeuXT4AOACppzPbHWgY1hFyp1P5fqnXt0Bz0wOeGEDCNuAqXOkQ+hG5w5ExObO
         OR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683909606; x=1686501606;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gOPr8RiZNSgqggpmzVuoRlbviV7C/s+3BUUqAAb6inU=;
        b=HQCfSbIea/CxUIZwbbqW3T94c+9721kUxZ2mxLjkgQs94a3pKSjWSFEVER8m5ZL7J+
         rdUMpG+hyVlr+XQ6KX24vJ4EXJZf/0LK+dRdpJRssMThitn/vQ7BqBaaUWru/aOrkUEA
         +NcNRbmmd0fXH8w3lRxZgg60PdqSaE43Kg4er1ChiLhjnNQW8D4lAfM2cdkUf+4wiNz+
         YwXehIM7JPsXyIZMgZaVAuL5pSkscxdk4/CTjOqN5iHDGLR0kePiqUDGH5xFfwWRwEAR
         ekBSAvJgp0P+9mwVHSDRxHn5Xc+Rba4b0hLaRXuxSxlvMpn7OiUPw3TXsvk1PB2ewmA2
         8EiQ==
X-Gm-Message-State: AC+VfDyr4+3Pd8OUOwLrOPt5p4GnL2Jqo6weUpMQbrKBjbXZzGmETMg6
        jurtTXugS2nHWj23gT7wnbh9a9axkh4RIsxIMvY=
X-Google-Smtp-Source: ACHHUZ5yxbWW2Bv6DZDq5gkRtNdoEDpV2I3JPwHvYv23gd+IPRTMx71bA/LG2dz5CkgOQTwYpkRxhA==
X-Received: by 2002:a5d:5968:0:b0:2c9:e585:84b0 with SMTP id e40-20020a5d5968000000b002c9e58584b0mr16128939wri.1.1683909605667;
        Fri, 12 May 2023 09:40:05 -0700 (PDT)
Received: from localhost ([146.70.133.78])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003f42461ac75sm16140195wml.12.2023.05.12.09.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 09:40:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 18:40:03 +0200
Message-Id: <CSKG4WDA4MVH.1RVYIN4NYH4EA@vincent-arch>
Cc:     <linux-pci@vger.kernel.org>, <robh@kernel.org>, <heiko@sntech.de>,
        <kw@linux.com>, <shawn.lin@rock-chips.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-rockchip@lists.infradead.org>, <broonie@kernel.org>,
        <bhelgaas@google.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <lpieralisi@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Dan Johansen" <strit@manjaro.org>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
X-Mailer: aerc 0.15.1
References: <20230509153912.515218-1-vincenzopalazzodev@gmail.com>
 <20230509211902.GA1270901@bhelgaas>
In-Reply-To: <20230509211902.GA1270901@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>
> Thanks for raising this issue.  Let's see what we can do to address
> it.
>
> On Tue, May 09, 2023 at 05:39:12PM +0200, Vincenzo Palazzo wrote:
> > Add a configurable delay to the Rockchip PCIe driver to address
> > crashes that occur on some old devices, such as the Pine64 RockPro64.
> >=20
> > This issue is affecting the ARM community, but there is no
> > upstream solution for it yet.
>
> It sounds like this happens with several endpoints, right?  And I
> assume the endpoints work fine in other non-Rockchip systems?  If
> that's the case, my guess is the problem is with the Rockchip host
> controller and how it's initialized, not with the endpoints.
>
> The only delays and timeouts I see in the driver now are in
> rockchip_pcie_host_init_port(), where it waits for link training to
> complete.  I assume the link training did completely successfully
> since you don't mention either a gen1 or gen2 timeout (although the
> gen2 message is a dev_dbg() that normally wouldn't go to the console).
>
> I don't know that the spec contains a retrain timeout value.  Several
> other drivers use 1 second, while rockchip uses 500ms (for example,
> see LINK_RETRAIN_TIMEOUT and LINK_UP_TIMEOUT).
>
> I think we need to understand the issue better before adding a DT
> property and a module parameter.  Those are hard for users to deal
> with.  If we can figure out a value that works for everybody, it would
> be better to just hard-code it in the driver and use that all the
> time.
>
> A few minor style/formatting comments below just for future reference:

Due the recent email I think it is worth make a version 2 of this
patch with your suggestion? and iterate over it another time?

Cheers!

Vincent.
