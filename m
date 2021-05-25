Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A2A3907D8
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 19:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhEYRhK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 13:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231805AbhEYRgt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 13:36:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA816613D8;
        Tue, 25 May 2021 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621964119;
        bh=M8A1nXT/yj3+oZraxPz2Vq1un0XR20wQuqeDyOrrkxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bv1Q+danFZfltXm85Nh/mVoyjH1SgmY4RRNbtKJkYoktbF5KeWO0ker+d0L2Ys4oR
         nc0IDAfEEjpUL7axuuEVKEY372kDShHt455vjl9nQSnM7k2L0Ip2Dt73200pHX9NVh
         u0gF9w9vXkkHBdfIEKWfq94TJkFqh7uqimy54o21cUD+5pOZc51VgsVRpgGbaTfrDZ
         Ew6146+miHiVpQH3SirvNR2YXyA43OI8TEpaiM0e4Wv67dCtjhtiTugHS3jQTAB8V3
         2QlMd18zP0kyyYboLpHYOMgHx7qoR3M2kwr36og0pi1+FEc4E9BKaHxlAr71Nsis9e
         sHqLEP5YI7S9g==
Received: by pali.im (Postfix)
        id 5BCB06F0; Tue, 25 May 2021 19:35:17 +0200 (CEST)
Date:   Tue, 25 May 2021 19:35:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Sandor Bodo-Merle <sbodomerle@gmail.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
Message-ID: <20210525173517.xbpcaogmbaerhkck@pali>
References: <20210520120055.jl7vkqanv7wzeipq@pali>
 <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali>
 <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
 <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com>
 <87pmxgwh7o.wl-maz@kernel.org>
 <13a7e409-646d-40a7-17a0-4e4be011efb2@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13a7e409-646d-40a7-17a0-4e4be011efb2@broadcom.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 25 May 2021 10:27:54 Ray Jui wrote:
> platforms with single CPU core that Sandor and Pali use?

Just to note that I'm not using this driver and platform. I have just
spotted suspicious function in this driver and therefore I started this
discussion.
