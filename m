Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56725595A52
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 13:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiHPLhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiHPLhA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 07:37:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C47B1087;
        Tue, 16 Aug 2022 04:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4E7ECE17B0;
        Tue, 16 Aug 2022 11:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A26C433D6;
        Tue, 16 Aug 2022 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660647767;
        bh=oZPcqIdh79CnlZuSFlpmlXwKmwhadfFf6w9Z3zvBFKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMfBHffmJONrmTFIMUuHRzMihpur+dI+FJF2AK1BnZ9nrZWPfe8LhKLV/fXytFdVZ
         Kef0udxlh8oIv1JUcegVzVUu9J3xTWclFGcWeCteEhFlHTnB0Nd8F+GSsoeIAW/W7P
         ZPji/Czkfl8q8U4LHUhlARvDW8TLbLvYMCU0WwMWVSY6QFK4B+QYDHgOPFENFV2vda
         WW/fb4BG/tWzs6Fp+1XtkqjaQZUlb7Bk2aQwJgBe3tI/AxZgiXYFbcVDrZVRmZ3GgZ
         DYlnl1nSEmoUKaJ5YhEI3kLszlALuWQARZe/AF7zxMCvFkahnio/slu8AOoslJiKR5
         1t9Mntlti0L3Q==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, mani@kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: check return value after calling platform_get_resource_byname()
Date:   Tue, 16 Aug 2022 13:02:25 +0200
Message-Id: <166064770874.160374.17316650518985523856.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429080740.1294797-1-yangyingliang@huawei.com>
References: <20220429080740.1294797-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 Apr 2022 16:07:40 +0800, Yang Yingliang wrote:
> If platform_get_resource_byname() fails, 'mmio_res' will be set to null pointer,
> it will cause null-ptr-deref when it used in qcom_pcie_perst_deassert(), so we
> need check the return value.
> 
> 

Applied to pci/endpoint, thanks!

[1/1] PCI: qcom-ep: check return value after calling platform_get_resource_byname()
      https://git.kernel.org/lpieralisi/pci/c/a6f7fbae8371

Thanks,
Lorenzo
