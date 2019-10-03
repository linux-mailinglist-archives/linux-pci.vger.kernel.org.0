Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB94CA568
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 18:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404134AbfJCQeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 12:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392095AbfJCQeG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 12:34:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4263921783;
        Thu,  3 Oct 2019 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120445;
        bh=3Bz1OUoxGDjgeT98hppsGEw91e3Ye36LUrMKlBtqcSU=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=j/K162GHR8smbdtnU3kJ9VWiqmsrEwDD+5DiuSNo/q0iv/ITY+YoqW2+yjI1POSoX
         UhSWY7N6nAoeYF55YeI0ITa7Ya91LlcNCgn/L8LsNRbxn5mYuNKwbhWSHK+NX8cnXW
         fLO2UPAEPnRh95wTpBNoIcAzJl/2QPOMSTploa9s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191002160632.11140-1-krzk@kernel.org>
References: <20191002160632.11140-1-krzk@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Convert Generic Power Domain bindings to json-schema
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 09:34:04 -0700
Message-Id: <20191003163405.4263921783@mail.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Krzysztof Kozlowski (2019-10-02 09:06:30)
> Convert Generic Power Domain bindings to DT schema format using
> json-schema.  The consumer bindings are split to separate file.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

