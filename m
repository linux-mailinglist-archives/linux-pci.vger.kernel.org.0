Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7768A3B0257
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 13:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFVLIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 07:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhFVLIq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 07:08:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0E7061351;
        Tue, 22 Jun 2021 11:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624359990;
        bh=tkNOU3KSOZoUF6VdPE47mV5VaubKmE+YLjZc9m6B/WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/yGAqJPo7FcjH+soJIGd4rVoVpAg6ZNiOYFCpIBaTWurncNyH1Se12qE4P822dB0
         qiofqU4R1B3OINcxg6n6MQ8nPu27/l7y9Tzqo3fd0OZ56m1HVtWp5GBEBt+6YZbVay
         PJKmINNkrCbjbueC1AJR0OMDzCwoRmgMCij5NodGHrtqYxBG0+luQhEAtoSJrrgeOu
         7ziaiLhw3r45OyVs95NWyalpxMeEgT3yk2hlSTzp4xr7QdiR5sDArdi9LkhD5Fwntg
         NoA8dv9WEx+a5jwnc6YrFHAEWmia0i/cKTXlKW3iC/SV1oXTpEJyleCwv3CAmBRtAP
         pE08eZkAjrVmQ==
Received: by pali.im (Postfix)
        id EA073889; Tue, 22 Jun 2021 13:06:27 +0200 (CEST)
Date:   Tue, 22 Jun 2021 13:06:27 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210622110627.aqzxxtf2j3uxfeyl@pali>
References: <20210531090540.2663171-1-luca@lucaceresoli.net>
 <20210531133211.llyiq3jcfy25tmz4@pali>
 <8ff1c54f-bb29-1e40-8342-905e34361e1c@lucaceresoli.net>
 <9fdbada4-4902-cec1-f283-0d12e1d4ac64@ti.com>
 <20210531162242.jm73yzntzmilsvbg@pali>
 <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8207a53c-4de9-d0e5-295a-c165e7237e36@lucaceresoli.net>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Tuesday 22 June 2021 12:57:22 Luca Ceresoli wrote:
> Nothing happened after a few weeks... I understand that knowing the
> correct reset timings is relevant, but unfortunately I cannot help much
> in finding out the correct values.
> 
> However I'm wondering what should happen to this patch. It *does* fix a
> real bug, but potentially with an incorrect or non-optimal usleep range.
> Do we really want to ignore a bugfix because we are not sure about how
> long this delay should be?

As there is no better solution right now, I'm fine with your patch. But
patch needs to be approved by Lorenzo, so please wait for his final
answer.

I would suggest to add a comment for call "usleep_range(1000, 2000);"
that you have chosen some "random" values which worked fine on your
setup and that they fix mentioned bug. Comment just to mark this sleep
code that is suboptimal / not-so-correct and to prevent other people to
copy+paste this code into other (new) drivers...
