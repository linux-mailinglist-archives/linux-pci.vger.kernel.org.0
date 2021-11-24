Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3245B73B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 10:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhKXJU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 04:20:57 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60762 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229926AbhKXJUz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 04:20:55 -0500
Received: from [79.2.93.196] (port=52022 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mpoPR-00067i-6a; Wed, 24 Nov 2021 10:17:45 +0100
Subject: Re: [PATCH v3 2/3] arm64: dts: apple: t8103: Fix PCIe #PERST polarity
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        kernel-team@android.com
References: <20211123180636.80558-1-maz@kernel.org>
 <20211123180636.80558-3-maz@kernel.org>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <3ba6ece5-9fa5-1bd8-5d11-47e2c6bda9ec@lucaceresoli.net>
Date:   Wed, 24 Nov 2021 10:17:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123180636.80558-3-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 23/11/21 19:06, Marc Zyngier wrote:
> As the name indicates, #PERST is active low. So fix the DT description
> to match the HW behaviour.
> 
> Fixes: ff2a8d91d80c ("arm64: apple: Add PCIe node")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
