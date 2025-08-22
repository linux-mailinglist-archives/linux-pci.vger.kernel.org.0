Return-Path: <linux-pci+bounces-34552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C0B31628
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 13:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6969816CA4C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB8B2E5B3F;
	Fri, 22 Aug 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="dAUXjV4n"
X-Original-To: linux-pci@vger.kernel.org
Received: from 5.mo533.mail-out.ovh.net (5.mo533.mail-out.ovh.net [54.36.140.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1F21255D
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755861088; cv=none; b=SU4nHi/VDu2aGI4i3zhuaYO1Gz4knLEgugAmjsi7qKtPUeRyMignOoAjE5wjU5topaD4N6cxPB//w9H0hKzOb0iuyCJSPdwDAan8zBbZrnpfhfh7tCO0xhF2Ve/I6M+1UzPVT23q4mGRdXfi+yWY/X1XDiJnZXrdziWlXo1PIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755861088; c=relaxed/simple;
	bh=Ryaxrw4eT3nAdUGPXwQzb7ucMxWAqtq5xPrHy63u2ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eafXfweYQ+uNVixhtH7QDZQUs2bMGptV+AOgZaCVFGs2J0meAE+gnC73dIn57bpVbAVaC3wuLJ7Rssit4FSJgwYT4ECdEMW6+Rfo2xS++e7ifuv4JSfNiYJUQ++oBr7muyqAq+knnazikAhkcaZxYBZBCcY/PaywoPqwtbLex1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=dAUXjV4n; arc=none smtp.client-ip=54.36.140.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4c7cvB1LFjz5vst;
	Fri, 22 Aug 2025 11:11:18 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Fri, 22 Aug 2025 11:11:18 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.37.33])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c7cv971Cdz1xpF;
	Fri, 22 Aug 2025 11:11:17 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.10])
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 2C90F9A32F1;
	Fri, 22 Aug 2025 11:11:16 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-109S00348983bfb-2252-412c-9c76-f625bcf17fb6,
                    ADC0680FE15BB91110492B9A34CE42AA242C155A) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <26b90664-ac3d-4eac-b082-4ddb6297dd00@orca.pet>
Date: Fri, 22 Aug 2025 13:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some
 behaviour
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>,
 Lee Jones <lee@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250821101902.626329-2-marcos@orca.pet>
 <202508221142.ETxcEpjA-lkp@intel.com>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <202508221142.ETxcEpjA-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5788814372848948838
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpeetieeiteffgfffffeuudfgueeugfdtffeuueehtefhhfehhffffeeukeeivdeffeenucffohhmrghinhepghhithdqshgtmhdrtghomhdpghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdptddurdhorhhgnecukfhppeduvdejrddtrddtrddupdejledruddujedrvddvrddutdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfi
 grlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepohgvqdhksghuihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
DKIM-Signature: a=rsa-sha256; bh=ooMiXhCtrpCJThxBkirXE/4Y5yuLSDN6OaDBZRlDF4E=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755861078;
 v=1;
 b=dAUXjV4nXWjdCZe1KhXGKwDw8WbdNMlQabWe+tKmIGab50WLwSitojB1+6BLEQQmKZZvOknP
 FlukwtYeAgZYIXauIhtXOYCBvouGGbgf8/MZTLr83Y/3hw1D42HwMiBOZA0IbW9xpZLvudS2CZX
 HZ5/gCqUNd44sutWfMsprs0nCVkazjNG7T2Wd5CDD8oSP5MNGSgIMGh3XtSS60AUSyAU/KLdfyR
 Eg5bgSmB0Tiu8rhyzdoacOB0m8jnq4w3TYHIXxfJReI1tIU8/ZgiC9ZVeR/WUsYXL1y/NMmPznQ
 2mPwpfSTnxZAQ9LFlN7+p9HkI1y1Z6/6Ob97EwcQzKZZA==

El 22/08/2025 a las 5:27, kernel test robot escribió:
> Hi Marcos,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on brgl/gpio/for-next]
> [also build test ERROR on lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes pci/next pci/for-linus linus/master v6.17-rc2 next-20250821]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Del-Sol-Vives/gpio-gpio-regmap-add-flags-to-control-some-behaviour/20250821-182416
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
> patch link:    https://lore.kernel.org/r/20250821101902.626329-2-marcos%40orca.pet
> patch subject: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some behaviour
> config: x86_64-buildonly-randconfig-001-20250822 (https://download.01.org/0day-ci/archive/20250822/202508221142.ETxcEpjA-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508221142.ETxcEpjA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508221142.ETxcEpjA-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/gpio/gpio-fxl6408.c:11:
>>> include/linux/gpio/regmap.h:26:31: error: call to undeclared function 'BIT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>       26 |         GPIO_REGMAP_DIR_BEFORE_SET      = BIT(0),
>          |                                           ^
>>> include/linux/gpio/regmap.h:26:31: error: expression is not an integer constant expression
>       26 |         GPIO_REGMAP_DIR_BEFORE_SET      = BIT(0),
>          |                                           ^~~~~~
>    In file included from drivers/gpio/gpio-fxl6408.c:12:
>    In file included from include/linux/i2c.h:13:
>    In file included from include/linux/acpi.h:14:
>    In file included from include/linux/device.h:32:
>    In file included from include/linux/device/driver.h:21:
>    In file included from include/linux/module.h:20:
>    In file included from include/linux/elf.h:6:
>    In file included from arch/x86/include/asm/elf.h:10:
>    In file included from arch/x86/include/asm/ia32.h:7:
>    In file included from include/linux/compat.h:17:
>    In file included from include/linux/fs.h:34:
>    In file included from include/linux/percpu-rwsem.h:7:
>    In file included from include/linux/rcuwait.h:6:
>    In file included from include/linux/sched/signal.h:6:
>    include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
This is correct, thanks. I added a missing "#include <linux/bits.h>" to
fix it. Will be in a v4 of the patch set.

