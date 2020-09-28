Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54027B2AD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 19:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgI1RFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 13:05:22 -0400
Received: from foss.arm.com ([217.140.110.172]:55152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1RFW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 13:05:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D73B531B;
        Mon, 28 Sep 2020 10:05:21 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6DF03F6CF;
        Mon, 28 Sep 2020 10:05:20 -0700 (PDT)
Date:   Mon, 28 Sep 2020 18:05:15 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bean Huo <huobean@gmail.com>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
Subject: Re: [PATCH] PCI: kirin: Return -EPROBE_DEFER in case the gpio isn't
 ready
Message-ID: <20200928165645.GA17518@e121166-lin.cambridge.arm.com>
References: <20200918123800.19983-1-huobean@gmail.com>
 <20200921112209.GA2220@e121166-lin.cambridge.arm.com>
 <2f29372be8186f25222e370f5601019b4d95b7b3.camel@gmail.com>
 <9f5d395618ebd435a573527137370937ae3ef723.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f5d395618ebd435a573527137370937ae3ef723.camel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 26, 2020 at 09:49:56AM +0200, Bean Huo wrote:
> seems the Hisilicon PCI driver maintainers are absent, however, we are
> still using their old platform based on Kirin.
> 
> hi, Lorenzo
> is it possible to take this patch without Hisilicon maintainter's ACK?

I applied it to pci/kirin, tentatively for v5.10.

Lorenzo

> Thanks,
> Bean
> 
