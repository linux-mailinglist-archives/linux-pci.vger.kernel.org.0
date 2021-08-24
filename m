Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C03F5F7B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 15:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbhHXNwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 09:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234881AbhHXNwP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 09:52:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A837A6125F;
        Tue, 24 Aug 2021 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629813091;
        bh=DDs02mFyx3tsmzssMO7OhVM6ADxTWlrYOeH+E+FneN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9cn0Rcc+BybIouu8nKwyzjxAQ2KdKHe0Y8EuKwenyLD7dMFhXOMTZFfV57I6o1Tt
         7QMtaYedTXWMqukAdhRwdVa5WknjuhfL7smFxOBzqglnq13lW0PDgRQbw8OTDuAiD1
         iAoPIJx8wC0IvCA+sYpYIQ8KGJsZTyfjD/3Smkik=
Date:   Tue, 24 Aug 2021 15:42:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mei: improve Denverton HSM & IFSI support
Message-ID: <YST3N7Xkl74PIBGy@kroah.com>
References: <20210819150459.21545-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819150459.21545-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 05:04:59PM +0200, Lukas Bulwahn wrote:
> The Intel Denverton chip provides HSM & IFSI. In order to access
> HSM & IFSI at the same time, provide two HECI hardware IDs for accessing.
> 
> Suggested-by: Ionel-Catalin Mititelu <ionel-catalin.mititelu@intel.com>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Tomas, please pick this quick helpful extension for the hardware.

How about a version that can build first?  :)
