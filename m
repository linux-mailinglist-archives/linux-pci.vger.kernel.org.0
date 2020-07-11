Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC721C515
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgGKQNA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jul 2020 12:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgGKQM7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Jul 2020 12:12:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7782075F;
        Sat, 11 Jul 2020 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594483978;
        bh=n2ktXL7Lm8tI8qYhwAOWKKE+CTtfAlysoQtFNBza8OQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DICmeqXiU/xBy4RlrulZstDUbRxoW20fO2E8ZtP+r16L7btPxDHrkHlCP3HYReAV2
         tMGbeUSXW3wSPy4OnpUbb3UWpr9WNPvWPkuVmvW0g1xuAF31dGANEVFc0POZBRBiHS
         q8fVmNNvkyI5r0661FxoytvPCo4U3hEj4vK8yNck=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1593940680-2363-5-git-send-email-sivaprak@codeaurora.org>
References: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org> <1593940680-2363-5-git-send-email-sivaprak@codeaurora.org>
Subject: Re: [PATCH 4/9] clk: qcom: ipq8074: Add missing clocks for pcie
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
To:     agross@kernel.org, bhelgaas@google.com, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, kishon@ti.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mgautam@codeaurora.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sivaprak@codeaurora.org,
        smuthayy@codeaurora.org, svarbanov@mm-sol.com,
        varada@codeaurora.org, vkoul@kernel.org
Date:   Sat, 11 Jul 2020 09:12:57 -0700
Message-ID: <159448397791.1987609.10974763524448652875@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Sivaprakash Murugesan (2020-07-05 02:17:55)
> Add missing clocks and resets for pcie port0 of ipq8074 devices.
>=20
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---

Applied to clk-next
