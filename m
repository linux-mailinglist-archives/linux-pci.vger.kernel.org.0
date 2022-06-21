Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2619552DDD
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiFUJFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiFUJFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 05:05:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF9DFA0;
        Tue, 21 Jun 2022 02:05:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B1E6157D;
        Tue, 21 Jun 2022 09:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCC8C3411D;
        Tue, 21 Jun 2022 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655802346;
        bh=7mNxfcNU8Owcc0AruDgkcVQfuiIuDtolzMAIpwihElE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McOtBZ5BOzquTU+uRqVBdyq0Uf0OQj6hZqIPYEh7ZhqvU7Z2Yi/iNUlryqmKBuEIy
         eTGa5ry0yUKo74jHsBV3jt617yUGDMbplA2kZXg90E8zoTC0z8DgHZ5IdLa+FaRzMd
         y9oeQTVv/o46NQuGj1n7RMV8uNoknIZGYcd+sdgVvQZYnmR2oc3/T3VLEThqDdCjGk
         w3puGa/9PMRYayTsBtZQ4VOlxLSWpe12/Ex42/x6e5zXTojekfeILFRIbJVCZsXLpX
         3rNDpwIPnrDl59+JsBG1Im8Km4zGL498/7vOE+jrvZbz1POnaaksIswa2teWzMqRdq
         Zpl24EzQqrviA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3ZpL-0001fY-OQ; Tue, 21 Jun 2022 11:05:39 +0200
Date:   Tue, 21 Jun 2022 11:05:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Baruch Siach <baruch.siach@siklu.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 3/3] PCI: qcom: Add IPQ60xx support
Message-ID: <YrGJ46ep4SJY5GNp@hovoldconsulting.com>
References: <cover.1655799816.git.baruch@tkos.co.il>
 <f7f848653c99abbf9a0f877949a44e52329543ae.1655799816.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f848653c99abbf9a0f877949a44e52329543ae.1655799816.git.baruch@tkos.co.il>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 11:54:54AM +0300, Baruch Siach wrote:
> From: Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>
> 
> IPQ60xx series of SoCs have one port of PCIe gen 3. Add support for that
> platform.
> 
> The code is based on downstream[1] Codeaurora kernel v5.4 (branch
> win.linuxopenwrt.2.0).
> 
> Split out the DBI registers access part from .init into .post_init. DBI
> registers are only accessible after phy_power_on().
> 
> [1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> Tested-by: Robert Marko <robert.marko@sartura.hr>
> Signed-off-by: Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
