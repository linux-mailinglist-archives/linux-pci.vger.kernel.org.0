Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9234F6C71
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 23:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiDFVUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiDFVUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 17:20:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E01CA
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 13:11:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 4AF8F1F45905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649275905;
        bh=1SZ1WOXqu5WV/6I6tLHfRtLBrawOGjB+3tY304FFedk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EuejPVkE4emxnZpgYc8GgnjejbgVdpjnYoISQz0RbUVvVGiZtRXPa66EAePzvee5S
         M71LnBeP1W0s7jGyHvai32s2ozboJAeodN7Y4UfX2Vx7Xcpk+dJqliXGlhKuO7w4ho
         uOiTAsz4R0jVAhfIsWTiQhF+tkM4IpkcC1tsFz7TZtVyBxHd8okUKLWXkCTlA/qEeF
         q6N2mFyj79zlGVLz6/Djaqq7uyuW0oWwFUl36KExUMah7PajfVaZTiH39wXu5cNUAj
         sxdINhEpEfKDBW1V1jOU1zxymM4+89JGWSfHFxK9SCFqslVmgvAMKaWwV1DZoBVZSb
         YhGdO6uTZIRxw==
Message-ID: <52fd4165-2e95-e9dc-79cf-63b2a8274d30@collabora.com>
Date:   Wed, 6 Apr 2022 21:11:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, linux-pci@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        "kernelci@groups.io" <kernelci@groups.io>,
        =?UTF-8?B?TWljaGHFgiBHYcWCa2E=?= <michal.galka@collabora.com>,
        Denys <denys.f@collabora.com>
References: <20220405235315.GA101393@bhelgaas>
 <20220406185931.GA165754@bhelgaas> <Yk3r9uhIHmNumtxi@sirena.org.uk>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <Yk3r9uhIHmNumtxi@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+kernelci +Michał +Denys

On 06/04/2022 20:37, Mark Brown wrote:
> On Wed, Apr 06, 2022 at 01:59:31PM -0500, Bjorn Helgaas wrote:
>> On Tue, Apr 05, 2022 at 06:53:17PM -0500, Bjorn Helgaas wrote:
> 
>>> Is there any way to get the contents of:
> 
>>>   /sys/firmware/acpi/tables/DSDT
>>>   /sys/firmware/acpi/tables/SSDT*
> 
>>> from these Chromebooks?
> 
>> Is there hope for this, or should I look for another way to get this
>> information?
> 
> I believe Guillaume is out of office this week.  Copying in Guenter as
> well since he's on the ChromeOS team in case he can help or knows
> someone who can.

Someone with access to the Collabora LAVA lab can also send a
custom job to try and get this information.

I'm back to work on Monday.

Thanks,
Guillaume
