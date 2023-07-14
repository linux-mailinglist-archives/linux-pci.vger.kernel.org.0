Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97107753C6D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjGNOCb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjGNOCb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 10:02:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA92269F
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2023 07:02:29 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bff89873d34so1732537276.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2023 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20221208.gappssmtp.com; s=20221208; t=1689343348; x=1691935348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UE2pP3kr6N661bURVuxZqsXqodClTm8wp0msbgmiIH4=;
        b=MXEeWfqY2mgAgr5E9wbHzY4ZYoUoDnUnhnH4sh3G0mbF5ftopFspvE0b0UDi/Ug00R
         bdzDD0NyPXjiv2DGQDScCJQjNWryU+un5bh5PRJtmFqlaHXEW2gT7cLW8JMqe4lbWR/6
         rvPCprvTemiHzugEoTDCEYpBx+neVJ2NGR7cwzULmmwuLKQEpMsuW3KwtoPxa8V6EEIJ
         LV+3UTfp3xaO9qaX/7Oizkx27gThCe6Uv+EX/h1qsAAMkE6bPKQvnLScK2XPXqSKay91
         jKdsQXWuPuP7NWN2cScAslRKio3KZP7YyR/II1Jl/SiIYnxXp6gT552refvlEYL9HgMI
         L7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343348; x=1691935348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UE2pP3kr6N661bURVuxZqsXqodClTm8wp0msbgmiIH4=;
        b=MHmPVx5NmVg2XD3kyL7uCNTf7SA4nFh8l95h1PYToSfUwvYWuxX6Mw1SMbbjNlXSYW
         CUxxBHUDeCHo7JVB/wLwQWQFxo+ecVnltvY4a3LZZJSlcqDR64QeGR/hie+4LQEUTzM3
         6shyfuIJcC/W3QeKGS1NoFVdBWkvKGgSXt0MyZhIfOSeBuOKPDbfKZrg7TbEy7knou2i
         efofLJUBPGTfQBpnesvLyOkjn+XMRyCP7SSMC20O+LdVxCwkRJQxPdgWdGjf8eiM33C4
         v8SFFNd6Y1HF3oELcqHy+PKUcEvSe8XIUQSGGXDyJAwN2uCVPgTy6cz8dyqqp/wdUCYf
         WtQA==
X-Gm-Message-State: ABy/qLYy9maJVNQLJQfUVabo/5RqZs+slVGq2xS6yJp+azugoidcjPoZ
        p6So5vIvvDxwXTdyRxBF9eLK5kzY9jXFdzi0nYUADw==
X-Google-Smtp-Source: APBJJlHS/oqNNmU6mDCZBTm1FqpDFiEIjuyfTLPHbX8EIeNAEAfjvZr6HPwCNvC67uJvxzFt9wasxruRv+DK3J/Qu3c=
X-Received: by 2002:a25:e7c3:0:b0:c12:fb0e:52a0 with SMTP id
 e186-20020a25e7c3000000b00c12fb0e52a0mr4112693ybh.19.1689343348754; Fri, 14
 Jul 2023 07:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230713171851.73052-1-sebastian.reichel@collabora.com> <20230713171851.73052-4-sebastian.reichel@collabora.com>
In-Reply-To: <20230713171851.73052-4-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Fri, 14 Jul 2023 19:32:17 +0530
Message-ID: <CA+VMnFzh1-rnDoY_hS-iqjDrOYwDAQXBBg9KUHAVBvaoUH=ZoQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: rk3588: add PCIe2 support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com, Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 13 Jul 2023 at 22:49, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Add all three PCIe2 IP blocks to the RK3588 DT. Note, that RK3588
> also has two PCIe3 IP blocks, that will be handled separately.
>
> Co-developed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Tested all pcie2x1l0 and pcie2x1l1 IP blocks in edgeble-neu6a, 6b.

Tested-by: Jagan Teki <jagan@edgeble.ai> # edgeble-neu6a, 6b
Reviewed-by: Jagan Teki <jagan@edgeble.ai>
