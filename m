Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC1175F7DB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGXNJO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGXNJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 09:09:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B406B7;
        Mon, 24 Jul 2023 06:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 083B661167;
        Mon, 24 Jul 2023 13:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65EBC433C8;
        Mon, 24 Jul 2023 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690204152;
        bh=bqj0qc6F2RAS2pFRIJnXo55WQzynV/DUzSrrH+mRIns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKDJ2GjRqhzuMfS7jW1QgIj9P4r2MNDTDvv9Z4rN3mbSjgqhM1f4uWC0slCinrONS
         uEmyTLr42hFasmjBvC0ZaF31dpEJrv7Rj9zdY60HZ3v7vHNi9aKJzOtUajK4t2GUD3
         upOSt4lxMvGv51WonaeNO4WN72l3NtMYJGKYFClaYG9zsQ3gX4MbI+tq30mjBUKkXt
         OzdjTZG6qgQRpy+ztSviOpA1KChG4sLIBPsow0xIos4GhtwI2VNkixP5PHO5aNGlQ7
         TbvA4P8H+x9IX6k+6h9Xen6HcGX/40GYJ/BOGSu3WFTxZr4Bdnw9k246+LCdQyfZ2s
         Ig86OoAWnCZKA==
Date:   Mon, 24 Jul 2023 18:38:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com
Subject: Re: [PATCH 1/1] PCI: qcom: Add early fixup to set the max payload
 size for IPQ9574
Message-ID: <20230724130855.GO6291@thinkpad>
References: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
 <20230724124711.2346886-2-quic_ipkumar@quicinc.com>
 <af7d1db2-8bbe-e078-6b17-7f841fb7f475@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af7d1db2-8bbe-e078-6b17-7f841fb7f475@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 02:53:37PM +0200, Konrad Dybcio wrote:
> On 24.07.2023 14:47, Praveenkumar I wrote:
> > Set 256 bytes as payload size for IPQ9574 via early fixup. This allows
> > PCIe RC to use the max payload size when a capable link partner is
> > connected.
> > 
> > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > ---
> [...]
> 
> > 
> > +static void qcom_fixup_mps_256(struct pci_dev *dev)
> > +{
> > +	pcie_set_mps(dev, 256);
> Looks like setting "dev->pcie_mpss = 1" here would make the PCIe generic
> code take care of this.
> 

Right, also this setting should not be PCI-PCI bridge specific but rather
controller specific.

- Mani

> Konrad

-- 
மணிவண்ணன் சதாசிவம்
