Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3C46CE95
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 08:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbhLHH7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 02:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhLHH7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 02:59:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44BEC061574
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 23:55:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74305B81FD1
        for <linux-pci@vger.kernel.org>; Wed,  8 Dec 2021 07:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3432AC341C3;
        Wed,  8 Dec 2021 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638950150;
        bh=PxNDxRZwodK5EIQbm2JOBgDuIGq0jIdGt+MECXlTRT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UGPRxze+rKU9fWLNK77rxDI7/jpwLQDpt+WNgsD5wyZdeM9hmSwT4RVUNlYT+pGTY
         uGAQrEEQpzSzCSCjpZ+9HjxPwHzYLOv8R4JLEey9OFryBdddLAvn9l67Qyy3I+q/OW
         +Z/17LJGY7gqQm3+7R9E0qIipw2UQukPnU8eQ3Px8nuNFFBLZZGuLjpsWYk2skrHxA
         x2n0fCL2EMtq/bI5Pvwf7eZ7mtDnlVdcxraqXMI/L4UsRRdHTwBA3QYs41yNEKFvF6
         th/uZ7qXkPyELcHIyz0Z0d+7mkwlSd5VPVCxOgBlSpSo8DuwXGvoJqzTfDApAzTYpc
         J9wpKju1vz6vg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1murno-00Ai8g-4E; Wed, 08 Dec 2021 07:55:48 +0000
MIME-Version: 1.0
Date:   Wed, 08 Dec 2021 07:55:48 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 00/17] PCI: aardvark controller fixes BATCH 4
In-Reply-To: <20211208072205.47134b27@thinkpad>
References: <20211208061851.31867-1-kabel@kernel.org>
 <20211208072205.47134b27@thinkpad>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <e5c1f563f8b4eed36a2bf68bead00f83@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: kabel@kernel.org, lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org, pali@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-12-08 06:22, Marek Behún wrote:
> Hello Marc,
> 
> sorry about this, I wanted to send this series also to you, but
> I accidentally sent it to your @arm.com e-mail address.
> Does that address still work? Should I resend to your @kernel.org
> address?

My @arm.com address stopped working over two years ago. I guess
my ex-manager is busy reviewing your patches!

No need to resend, I'll fetch the series from lore.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
