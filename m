Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB62FA46F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 16:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405711AbhARPT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 10:19:57 -0500
Received: from foss.arm.com ([217.140.110.172]:37798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405703AbhARPTz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 10:19:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D23641FB;
        Mon, 18 Jan 2021 07:19:09 -0800 (PST)
Received: from e123427-lin.arm.com (unknown [10.57.56.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EFC03F68F;
        Mon, 18 Jan 2021 07:19:08 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        devicetree@vger.kernel.org, bhelgaas@google.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        minghuan.Lian@nxp.com, roy.zang@nxp.com, mingkai.hu@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: pci: layerscape-pci: Add compatible strings for LX2160A rev2
Date:   Mon, 18 Jan 2021 15:19:01 +0000
Message-Id: <161098310099.10311.14933028108070185453.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201026051448.1913-1-Zhiqiang.Hou@nxp.com>
References: <20201026051448.1913-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 26 Oct 2020 13:14:47 +0800, Zhiqiang Hou wrote:
> Add PCIe Endpoint mode compatible string "fsl,lx2160ar2-pcie-ep"

Applied to pci/dwc, thanks!

[1/2] dt-bindings: pci: layerscape-pci: Add compatible strings for LX2160A rev2
      https://git.kernel.org/lpieralisi/pci/c/514a39a653
[2/2] PCI: layerscape: Add EP mode support for LX2160A rev2
      https://git.kernel.org/lpieralisi/pci/c/faff7b5ef5

Thanks,
Lorenzo
