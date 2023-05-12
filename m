Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809A9700365
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbjELJKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjELJKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 05:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2A626AE;
        Fri, 12 May 2023 02:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B51261252;
        Fri, 12 May 2023 09:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 939DFC4339E;
        Fri, 12 May 2023 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683882621;
        bh=EoEjquT3vvrEk097Sv5efwEoqOJVpBvoSDCmCg2pzbM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZFZ48+qyyvd1vrRPro0njxf5O0AYoCWl1gHcFCmYoUuclrk5KDnd1ZyjxoCjuUd4h
         cxiI8ED0poScHh4bKSW4NbRJMA9jOM0cwcwRjvGByUuhGFblB9XfO7QVJj44wyZW9M
         Wh02c5K/aqQWbWIlSB6lC3a3q1xMSU+wkDVjKNjZFptn/V5o4j5Hb+kclIzOtS/Z+v
         2ueBDZ8kizIICYjSTMae8c9mYkdTnatPOrrLWfQXEf7P8BDHi+Vaaxf72Q420dFg/y
         oXwoWTryQo/yBdOvwQqFxJPfbpeaSVexrRAcDktwTM98l8akD0M1y2hRCduijBOXhx
         i3c/qJUr++P7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76D3FE501EF;
        Fri, 12 May 2023 09:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] vsock: avoid to close connected socket after the
 timeout
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168388262147.3920.8279144932756788289.git-patchwork-notify@kernel.org>
Date:   Fri, 12 May 2023 09:10:21 +0000
References: <20230511113430.646292-1-zhuangshengen@huawei.com>
In-Reply-To: <20230511113430.646292-1-zhuangshengen@huawei.com>
To:     Zhuang Shengen <zhuangshengen@huawei.com>
Cc:     sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, arei.gonglei@huawei.com,
        longpeng2@huawei.com, jianjay.zhou@huawei.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 May 2023 19:34:30 +0800 you wrote:
> When client and server establish a connection through vsock,
> the client send a request to the server to initiate the connection,
> then start a timer to wait for the server's response. When the server's
> RESPONSE message arrives, the timer also times out and exits. The
> server's RESPONSE message is processed first, and the connection is
> established. However, the client's timer also times out, the original
> processing logic of the client is to directly set the state of this vsock
> to CLOSE and return ETIMEDOUT. It will not notify the server when the port
> is released, causing the server port remain.
> when client's vsock_connect timeout，it should check sk state is
> ESTABLISHED or not. if sk state is ESTABLISHED, it means the connection
> is established, the client should not set the sk state to CLOSE
> 
> [...]

Here is the summary with links:
  - [net,v2] vsock: avoid to close connected socket after the timeout
    https://git.kernel.org/netdev/net/c/6d4486efe9c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


