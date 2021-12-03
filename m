Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C00467D37
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 19:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbhLCS0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 13:26:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40596 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239904AbhLCS0e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 13:26:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC97F62C76;
        Fri,  3 Dec 2021 18:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E3C53FAD;
        Fri,  3 Dec 2021 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638555789;
        bh=O+74SeU5bXu+2D4h2dTqogHeS9Dy9DBwyhECCzKoAKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sS3dVaRMYZzmda6SNglE45eQfTbUyqmRxil4WtjvP7ifLaCBfnHi3D5a3k/NkQ2mg
         yKTwjykPfaHL1nQJHPpw0UbZq9hhm/11EqmDZ8FskjrKv9EGQfaTa5+H+UbKrI6Z4h
         t5FA3fil7LrzbT2tqOLvXOakUmYD56V2yYtyHXsJec2lfPz8JNmHOQp4AjyjHScVCG
         6wff/JF8T8zAiNV5IiIQj4fh51XfMViAv8vCf1FnZHys1FaHlpaxhLKjsh/VIjkky/
         TAfPXQsT4/c9Wet3XwtDZxcalJluSUiZ44WRfvc83hteAeOBdC3kC5NFsXwNeF2kP/
         K2p7UtuzgBABA==
Date:   Fri, 3 Dec 2021 12:23:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux@roeck-us.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mt7621: Kconfig: Convert driver into 'bool'
Message-ID: <20211203182307.GA3013031@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201213402.22802-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/PCI: mt7621: Kconfig:/PCI: mt7621:/

in subject.  You can run "git log --oneline
drivers/pci/controller/Kconfig" to learn the convention.

On Wed, Dec 01, 2021 at 10:34:02PM +0100, Sergio Paracuellos wrote:
> Driver is not ready yet to be compiled as a module since it depends on some
> MIPS not exported symbols. We have the following current problems:
> ...
