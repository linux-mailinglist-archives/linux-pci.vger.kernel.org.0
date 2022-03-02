Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5374C9EC0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 08:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiCBH5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 02:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbiCBH5j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 02:57:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF0AB65FD;
        Tue,  1 Mar 2022 23:56:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91987B81ED1;
        Wed,  2 Mar 2022 07:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAE0C340EF;
        Wed,  2 Mar 2022 07:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646207814;
        bh=JYbbdsaBqD5/502ywVV+VKKTgTlTw8DfkQh/iGv+Daw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSxrNTgdWEumQjkGMMueHIzmjBIX7UynSi4qfec4jZKr641Zqr+MrVoFBba8FWitp
         WutkCJErKwxRM8J+BmMAg1M4BY5q5JMJ9TF+iUmrzZyGE8BiR9GMpmFFeNVjyku8QD
         Vq4h6zuP2A6zcQTvwrb64I+b21A+kjCPPijDa68U=
Date:   Wed, 2 Mar 2022 08:56:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Youngjin Jang <yj84.jang@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        js07.lee@samsung.com
Subject: Re: [PATCH] PM: Add device name to suspend_report_result()
Message-ID: <Yh8jQrJLVXaKCbDk@kroah.com>
References: <CGME20220302064921epcas1p19fbe8c017d776657caa696a3cef10093@epcas1p1.samsung.com>
 <20220302064917.64073-1-yj84.jang@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302064917.64073-1-yj84.jang@samsung.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 03:49:17PM +0900, Youngjin Jang wrote:
> From: "yj84.jang" <yj84.jang@samsung.com>

Please use a real name here, I doubt that is how you sign legal
documents :)

thanks,

greg k-h
