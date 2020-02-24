Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4316A0A5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 09:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBXIxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 03:53:37 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:57057 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgBXIxh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 03:53:37 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B794923059;
        Mon, 24 Feb 2020 09:53:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582534414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGHRW3l5rCA287QCNNdGXSdyqq9QPHkLJ+IpgLfP+T0=;
        b=Ta29z0+G9GOKfOY5pEnNbXDdYrHts1jhuNXUK+UU5pGYZYKRousrquA57hOniFUq4neRJv
        CWF0Ds23phwNWukPNrMpGKwE0OE5mmUIhqM0t2PymJhANWOk8Jh/P/Ff1ecxm+VF0nYmBQ
        +xZno6FiY9P/UzW4OQIkZlENAnPp3wU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Feb 2020 09:53:34 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     xiaowei.bao@nxp.com, Zhiqiang.Hou@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com
Subject: Re: [PATCH v6 2/3] arm64: dts: ls1028a: Add PCIe controller DT nodes
In-Reply-To: <20200224084307.GD27688@dragon>
References: <20190902034319.14026-2-xiaowei.bao@nxp.com>
 <20200224081105.13878-1-michael@walle.cc> <20200224084307.GD27688@dragon>
Message-ID: <a3aeabddc82ca86e3dca9c26081a0077@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: B794923059
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[16];
         NEURAL_HAM(-0.00)[-0.572];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shawn, all,

Am 2020-02-24 09:43, schrieb Shawn Guo:
> On Mon, Feb 24, 2020 at 09:11:05AM +0100, Michael Walle wrote:
>> Hi Xiaowei, Hi Shawn,
>> 
>> > LS1028a implements 2 PCIe 3.0 controllers.
>> 
>> Patch 1/3 and 3/3 are in Linus' tree but nobody seems to care about 
>> this patch
>> anymore :(
>> 
>> This doesn't work well with the IOMMU, because the iommu-map property 
>> is
>> missing. The bootloader needs the &smmu phandle to fixup the entry. 
>> See
>> below.
>> 
>> Shawn, will you add this patch to your tree once its fixed, 
>> considering it
>> just adds the device tree node for the LS1028A?
> 
> The patch/thread is a bit aged.  You may want to send an updated patch
> for discussion.

So should I just pick up the patch add my two fixes and send it again? 
What about
the Signed-off-by tags? Leave them? Replace them? Add mine?

-michael
