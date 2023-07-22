Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33F475D9A6
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jul 2023 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGVEYI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jul 2023 00:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVEYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2023 00:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704210C3;
        Fri, 21 Jul 2023 21:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF7C60918;
        Sat, 22 Jul 2023 04:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA85DC433C8;
        Sat, 22 Jul 2023 04:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689999846;
        bh=h5XuZr98sjwlO7gDdMo7HLiufEe+Jm9DBn3LdnntEBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6qxb05TIsnO+2TbAww91awPBspLbIwAWkD+O1nOnxYvfrCo37N4Dfh8ft/f7DDqk
         C+O+SmgR7aV2Rekws17TW+tA2jeZoKxUZx743tnJgBJmYTsjhYzHGpNYMkV3LOoX2N
         JlMqqXFnOExkxh8S+bTc99Gig9jxMG/EDqGwZuTHVjlYbM+aUNuR2/CJipXTKIwBfr
         N49wMSapRU55Wr3aM4NAZgKc+FPuWIhcABwfTZEHj3P1MeYWz7YXciZY0W6e6fhp8u
         DHKodfn1HSBBMcHlxNG5hI2fVdptgTwwa82Z/gvQdD/Fi+PFhA+SrkZVG8zYsanJpI
         i+v5m5XsKIP5g==
Date:   Fri, 21 Jul 2023 21:27:24 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI: qcom: Add support for sa8775p SoC
Message-ID: <4stjo474xkq4d7wwsonpvvj37txsq5mqok3uqi2dj5e3xmgkv2@rl22supr2jin>
References: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
 <1689960276-29266-3-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689960276-29266-3-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 10:54:33PM +0530, Mrinmay Sarkar wrote:
> Add support for sa8775p SoC that uses controller version 5.90
> reusing the 1.9.0 config.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
