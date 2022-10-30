Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E3612A93
	for <lists+linux-pci@lfdr.de>; Sun, 30 Oct 2022 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ3MZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Oct 2022 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3MZ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Oct 2022 08:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3353E1B1;
        Sun, 30 Oct 2022 05:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42B860DFD;
        Sun, 30 Oct 2022 12:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3669C433C1;
        Sun, 30 Oct 2022 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667132727;
        bh=8WVf6807pwphI1dXEwQpsvpZJ8jktxWXzKRXjmkztlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iw6+VgHIRjH01QPIV+N60+nK2thtqxdxlwtDp6I0g58AvQWQgzBeQ6Tv2R5wd5fDB
         xWs/h/Iga/+d2ql6UPbGI4cFjA9OscgQg6rJlRjTLNcf6ngs6LsuYAgNBb3FPs8p0v
         CO4kovLqGUijgaXMZyOQn9rcC9hhlrTTxI66RrLmbqFaOzBNXiKLnfxDRRv398bJ1D
         kWIBzudRdmjNN+mi+O45sJd/jfrAaLl7v8wROvZdgGFIuw3O2WTNQv241Of0BK4goB
         /0uSrDzLurV5AqaT2fZIpL/2SV2PL8qZCs75XXJpZOs0n1FtFiWfjxyDKp/gq6YaOB
         z4OHux2NqTyVQ==
Date:   Sun, 30 Oct 2022 07:25:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 4/7] phy: qcom-qmp-pcie: split and rename the sm8450
 gen3 PHY config tables
Message-ID: <20221030122525.GA1022832@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029211312.929862-5-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 30, 2022 at 12:13:09AM +0300, Dmitry Baryshkov wrote:
> SM8350 PHY config tables are mostly the same as SM8450 gen3 PHY config
> tables. Split these tables to be used by SM8350 config. Following this
> split rename generic tables to remove x1 suffix.

Commit logs that say "Following this ..." always make me ask whether
this could or should be split into two patches, one that is a trivial
rename that's easier to review.

But I guess this is a phy patch that Lorenzo will look for somebody
else to ack :)

Bjorn
