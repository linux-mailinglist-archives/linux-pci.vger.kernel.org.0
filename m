Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F987CFA7D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 15:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbjJSNLY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbjJSNLX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 09:11:23 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DDA115
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 06:11:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7af52ee31so96973487b3.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Oct 2023 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697721078; x=1698325878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKyigxz0xjpNw4M9S8MD6bISZmwbP5guXuL2FXnbjpY=;
        b=XaPSNc/EkHrq7X9uxr8/IsBI0imoaNWGdEVTDqy98z4Hd72So2ByBCBgYbYFeLLnjl
         GA7PZHBCFJx35lN8m6UPkIjGWhv60ncQQs/dP27hF56JFjYN+Z8hIazsPYjoBVbatj0u
         /v8nUTf8ZFj1ldHumvx5VzrhiQOyhb4ftYH/s4eTmV1k3jsyohq9GID0lsQF6HLtNvbd
         4izlaMasNvY56v/WK7zM+CZ7hNe3/oOxxijppHrOVlWwkK9Rcb7B86K1H1WJBWbzC7Lt
         eKR9iIXcKBKR5CUTL2qSEvvdgpTTU5gV4Jl1JXBWy/Ra+9WcusznqEqgJXZggaZR1nYt
         GAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721078; x=1698325878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKyigxz0xjpNw4M9S8MD6bISZmwbP5guXuL2FXnbjpY=;
        b=ccJGOXwp+XUvau4oMbVj6xxYk5fM2AeKimxte+7xHpNAZ6K6aHyH8aOKsKOJd/DsQo
         zDTZOQdlnn9Ul4skzOPq3B/+mDqAI2YBXjzkWk+WjGzhG8sVfM0GUbT3zDFax/LXUu/8
         QFoD5f2K3usUlohIemDYypAy68M/JWZ8xH6TNGmELqkSS5wA18/ECyMd2Ble5gzDIdM4
         InwVu5t+M585mcWalSEz40ypnZMHtLGOc2Lat4E3yEpBKJrQlMCNpPh45WapV6DeAm7I
         SdzsTrnToPqdBtc3i2R3yy/Ka/o6F03abvOIDBrh7sCXI7QzA6tUIihsvysfWL4GEEeF
         W22A==
X-Gm-Message-State: AOJu0YzHnHTPO3XqgXF0KcKM0O45Lj/H33aFnQ586+Nhv4NS35aDbu0T
        KFk+EioYR57G+2i6ST5Aq0CJsuipwYfqeUq56pYBuQ==
X-Google-Smtp-Source: AGHT+IFTDmViD4G59KbU+RTJg6WzdOrllTZxG71eprBWbjW7yf0Y2TxoOzGTmJh67kNKv4S5EHKdAM9I6+sYql2eQS4=
X-Received: by 2002:a0d:c1c2:0:b0:5a8:1058:5d97 with SMTP id
 c185-20020a0dc1c2000000b005a810585d97mr2524844ywd.45.1697721078519; Thu, 19
 Oct 2023 06:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com> <1697715430-30820-4-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1697715430-30820-4-git-send-email-quic_msarkar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Oct 2023 16:11:07 +0300
Message-ID: <CAA8EJpoAQbTT6KZWeD4_PSxDCG0tZ_PvGmUXxpAfHxrK5CAUcg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] phy: qcom-qmp-pcie: add endpoint support for sa8775p
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 19 Oct 2023 at 14:37, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
> Add support for dual lane end point mode PHY found on sa8755p platform.
>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 37 +++++++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h |  2 ++
>  2 files changed, 39 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
