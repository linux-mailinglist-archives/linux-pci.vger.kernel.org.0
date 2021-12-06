Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804794693F8
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 11:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhLFKen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 05:34:43 -0500
Received: from foss.arm.com ([217.140.110.172]:53566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237997AbhLFKen (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 05:34:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A29911FB;
        Mon,  6 Dec 2021 02:31:14 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.33.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0BFE3F73D;
        Mon,  6 Dec 2021 02:31:11 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bhelgaas@google.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, svarbanov@mm-sol.com,
        kernel test robot <lkp@intel.com>, bjorn.andersson@linaro.org
Subject: Re: [PATCH v3] PCI: qcom: Use __be16 type to store return value from cpu_to_be16()
Date:   Mon,  6 Dec 2021 10:31:02 +0000
Message-Id: <163878663178.16251.482948854423649218.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211130080924.266116-1-manivannan.sadhasivam@linaro.org>
References: <20211130080924.266116-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Nov 2021 13:39:24 +0530, Manivannan Sadhasivam wrote:
> cpu_to_be16() returns __be16 value but the driver uses u16 and that's
> incorrect. Fix it by using __be16 as the data type of bdf_be variable.
> 
> The issue was spotted by the below sparse warning:
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [usertype] bdf_be @@     got restricted __be16 [usertype] @@
>    drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     expected unsigned short [usertype] bdf_be
>    drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     got restricted __be16 [usertype]
> 
> [...]

Applied to pci/qcom, thanks!

[1/1] PCI: qcom: Use __be16 type to store return value from cpu_to_be16()
      https://git.kernel.org/lpieralisi/pci/c/3f13d611aa

Thanks,
Lorenzo
