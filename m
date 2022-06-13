Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F2654A112
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244882AbiFMVPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351797AbiFMVPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:15:00 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB0442ECD;
        Mon, 13 Jun 2022 13:56:52 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id y17so5164411ilj.11;
        Mon, 13 Jun 2022 13:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yt41bj0ywHBIDYHLFJu4/UlU99lD5AlXqc6jUi0C48E=;
        b=ENUwXJFp1e4S1Y9SqOagD1nbx2uTtggfxA6A1oWID0hhpHRg/jWRKRAJOHkHPkZmKF
         ZpR/2TB5iDu5U1niUjIhGfhQEBC4FpbO+jgA4HGDHy4Cw35tJwJ2J/RzRfu7VYcdGPb+
         lgx2ukdpgnhNCnv+tA7QW2bT90GaFnq8kvssqQGJEk+xHE/qudkc9kvVjHhevezdCrsv
         mINEwpwE5zRmrKkY5POVzJ6Z8aBmcwEv+JHZZKCOmRP8uZO93bQm4KPYJMZRHof3y1e8
         PESzNdSxi9RcbQvnZtbpvh3pC7XmbFWjPbuE3FGVswNptZzq4czoJ7VubQXj22jmfuO+
         VmuQ==
X-Gm-Message-State: AJIora9GK+dr3oMarL/9Fe75PKF5btZi+YGaAHvOIAUpJU0D+RFAZfwL
        wLoc+jCXh5N6V1UjvsXfDg==
X-Google-Smtp-Source: AGRyM1vTCta0IBWSQN1YXrUc/7fP2gjHAOcfvbOWzNusHk/g+rsMXnnKTwYKMN90xrvkRaKzIHwu7w==
X-Received: by 2002:a92:c98a:0:b0:2d5:2704:6dab with SMTP id y10-20020a92c98a000000b002d527046dabmr998149iln.23.1655153812116;
        Mon, 13 Jun 2022 13:56:52 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id b11-20020a02380b000000b00331598832besm3961325jaa.25.2022.06.13.13.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:56:51 -0700 (PDT)
Received: (nullmailer pid 69833 invoked by uid 1000);
        Mon, 13 Jun 2022 20:56:50 -0000
Date:   Mon, 13 Jun 2022 14:56:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Baruch Siach <baruch.siach@siklu.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 2/3] PCI: qcom: Define slot capabilities using
 PCI_EXP_SLTCAP_*
Message-ID: <20220613205650.GA62642-robh@kernel.org>
References: <cover.1655028401.git.baruch@tkos.co.il>
 <27d2c59cc9a916754e0dc68f44447ecefe378410.1655028401.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27d2c59cc9a916754e0dc68f44447ecefe378410.1655028401.git.baruch@tkos.co.il>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 12, 2022 at 01:18:34PM +0300, Baruch Siach wrote:
> From: Baruch Siach <baruch.siach@siklu.com>
> 
> The PCIE_CAP_LINK1_VAL macro actually defines slot capabilities. Use
> PCI_EXP_SLTCAP_* macros to spell its value, and rename it to better
> describe its meaning.
> 
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> ---
> v7:
>   Use FIELD_PREP for power limit and stale (Pali Rohár)
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
