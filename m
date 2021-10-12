Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85642A4D2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhJLMtc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 08:49:32 -0400
Received: from foss.arm.com ([217.140.110.172]:40230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236281AbhJLMtb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 08:49:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF1CC1FB;
        Tue, 12 Oct 2021 05:47:29 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D59B33F70D;
        Tue, 12 Oct 2021 05:47:27 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Perform host_init() before registering msi
Date:   Tue, 12 Oct 2021 13:47:22 +0100
Message-Id: <163404282734.17003.14339103260227096714.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210823154958.305677-1-bjorn.andersson@linaro.org>
References: <20210823154958.305677-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 23 Aug 2021 08:49:57 -0700, Bjorn Andersson wrote:
> On the Qualcomm sc8180x platform the bootloader does something related
> to PCI that leaves a pending "msi" interrupt, which with the current
> ordering often fires before init has a chance to enable the clocks that
> are necessary for the interrupt handler to access the hardware.
> 
> Move the host_init() call before the registration of the "msi" interrupt
> handler to ensure the host driver has a chance to enable the clocks.
> 
> [...]

Applied to pci/dwc, thanks!

[1/2] PCI: dwc: Perform host_init() before registering msi
      https://git.kernel.org/lpieralisi/pci/c/7e919677bb
[2/2] PCI: qcom: Add sc8180x compatible
      https://git.kernel.org/lpieralisi/pci/c/0e00fc858f

Thanks,
Lorenzo
