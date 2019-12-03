Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC8CE112076
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2019 00:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLCXxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 18:53:11 -0500
Received: from alpha.anastas.io ([104.248.188.109]:60335 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLCXxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 18:53:11 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Dec 2019 18:53:11 EST
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 9CFD77F435;
        Tue,  3 Dec 2019 17:45:53 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1575416754; bh=mdtQhN24kYvuo/KKla+16YACVSx83u/SxcWjz3GMu8E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RX2KsrOyELqDyJKEfd8W1Ers5uUuvDUvvfYAFg6XgbIbA6Dckey5KVjDPF74PcUBQ
         NrHiAQZXIghL9EKTMP07O+k0eb/vwAr1tssHj22vWiosLf69W7T4EwTVX9piAEMtVP
         228LLnFgFxu0x4csQBxyuCDhkpFh/eZjtXIgvNrZUHw6Ips2d5QybFhqXfH2NQI5AW
         3RwRGMpBvyTTJRvNg1aABPio/OZ0n6+jED1XJr6MGrAw/JbsfWdH91f2dUhmehhqFF
         S2fBn2luLsnpXlEz/fB6vo4IH6DqHC9NkZ004KLil1717rrwCcntluSekIf6RdjDss
         Nukga9XSlvFIA==
Subject: Re: [PATCH v2 1/3] powernv/iov: Ensure the pdn for VFs always
 contains a valid PE number
To:     Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     aik@ozlabs.ru, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20191028085424.12006-1-oohall@gmail.com>
From:   Shawn Anastasio <shawn@anastas.io>
Message-ID: <166b9ee3-08fe-e558-b6a3-4ea5d9b9219f@anastas.io>
Date:   Tue, 3 Dec 2019 17:45:51 -0600
MIME-Version: 1.0
In-Reply-To: <20191028085424.12006-1-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/28/19 3:54 AM, Oliver O'Halloran wrote:
> On pseries there is a bug with adding hotplugged devices to an IOMMU group.
> For a number of dumb reasons fixing that bug first requires re-working how
> VFs are configured on PowerNV.

Are these patches expected to land soon, or is there another fix in the
pipeline? As far as I can tell this is still an issue.
