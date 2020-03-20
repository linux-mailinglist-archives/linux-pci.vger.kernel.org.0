Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A597118D7CA
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 19:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCTSvj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 14:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbgCTSvi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 14:51:38 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DBA920781;
        Fri, 20 Mar 2020 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584730297;
        bh=Pxh4RNwztfrlkMAQ30CdqLRP25VoysEoplJZh8LNfAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b/GHHrqqQTaSpCsOvb2WLrNC6efZgRm1ZyJ155O9mE4abE8nziYOLt+LDXMRkX34b
         MmwiWPl5oAPhPQEkQD/p6CEEebnt9w++UgPg/kiRSSCTr06fKVrVrefYknfIVcBqLU
         KUovYTZ+PSG2vO+pSVILi4rBxHn1cZHjcg3lDYdk=
Date:   Fri, 20 Mar 2020 13:51:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] pcie: qcom: add missing reset for ipq806x
Message-ID: <20200320185135.GA242507@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-5-ansuelsmth@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 07:34:47PM +0100, Ansuel Smith wrote:
> Add missing ext reset used by ipq806x soc in
> pcie qcom driver

You say "missing" -- does that mean this is a *new* requirement for
this ipq806x device, and previous devices work correctly without this
patch?

Or does this fix an omission and previous devices actually didn't work
correctly?

s/soc/SoC/
s/pcie/PCIe/

Period at end of sentence.  Please wrap to fill 75 columns.
